param(
    [string]$ProjectRoot = "",
    [string]$InputDir = "",
    [string]$OutputDir = "",
    [string]$BgmDir = "",
    [string]$ReportsDir = "",
    [string]$ToolsDir = "",
    [string]$VenvDir = "",
    [ValidateSet("ask", "4x3", "vertical", "horizontal", "source")]
    [string]$TargetProfile = "ask",
    [switch]$CreateVenv,
    [switch]$DownloadFfmpeg,
    [switch]$InstallPythonPackages,
    [switch]$WithTranscription
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-DefaultProjectRoot {
    return (Join-Path $env:USERPROFILE "auto-video-editing-workflow")
}

function Ensure-Directory([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
}

function Find-CommandPath([string]$Name) {
    $cmd = Get-Command $Name -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($cmd) { return $cmd.Source }
    return $null
}

function Get-LocalFfmpegPath([string]$Root) {
    return (Join-Path $Root "ffmpeg\bin\ffmpeg.exe")
}

function Install-Ffmpeg([string]$Root) {
    Ensure-Directory $Root
    $localFfmpeg = Get-LocalFfmpegPath $Root
    if (Test-Path -LiteralPath $localFfmpeg -PathType Leaf) {
        return $localFfmpeg
    }

    $zipPath = Join-Path $env:TEMP "ffmpeg-release-essentials.zip"
    $extractRoot = Join-Path $env:TEMP ("ffmpeg-" + [guid]::NewGuid().ToString("N"))
    $uri = "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip"

    Write-Host "Downloading FFmpeg from $uri"
    Invoke-WebRequest -Uri $uri -OutFile $zipPath
    Expand-Archive -LiteralPath $zipPath -DestinationPath $extractRoot

    $ffmpegExe = Get-ChildItem -LiteralPath $extractRoot -Recurse -Filter "ffmpeg.exe" |
        Select-Object -First 1
    if (-not $ffmpegExe) {
        throw "FFmpeg download expanded, but ffmpeg.exe was not found."
    }

    $binDir = Split-Path -Parent $ffmpegExe.FullName
    $sourceRoot = Split-Path -Parent $binDir
    $targetRoot = Join-Path $Root "ffmpeg"
    Ensure-Directory $targetRoot
    Copy-Item -LiteralPath (Join-Path $sourceRoot "bin") -Destination $targetRoot -Recurse -Force
    if (Test-Path -LiteralPath (Join-Path $sourceRoot "doc") -PathType Container) {
        Copy-Item -LiteralPath (Join-Path $sourceRoot "doc") -Destination $targetRoot -Recurse -Force
    }
    if (Test-Path -LiteralPath (Join-Path $sourceRoot "presets") -PathType Container) {
        Copy-Item -LiteralPath (Join-Path $sourceRoot "presets") -Destination $targetRoot -Recurse -Force
    }

    return $localFfmpeg
}

function Ensure-Venv([string]$Path) {
    $venvPython = Join-Path $Path "Scripts\python.exe"
    if (Test-Path -LiteralPath $venvPython -PathType Leaf) {
        return $venvPython
    }

    $python = Find-CommandPath "python"
    if (-not $python) {
        throw "Python was not found on PATH. Install Python 3.10+ first, then rerun this setup script."
    }

    & $python -m venv $Path
    if (-not (Test-Path -LiteralPath $venvPython -PathType Leaf)) {
        throw "Python virtual environment was not created successfully."
    }
    return $venvPython
}

function Install-PythonPackages([string]$PythonExe, [bool]$IncludeTranscription) {
    & $PythonExe -m pip install --upgrade pip wheel setuptools
    $packages = @(
        "moviepy",
        "auto-editor",
        "numpy",
        "Pillow",
        "opencv-python",
        "pydub"
    )
    if ($IncludeTranscription) {
        $packages += @(
            "faster-whisper",
            "openai-whisper"
        )
    }
    & $PythonExe -m pip install @packages
}

function Resolve-TargetProfile([string]$Profile) {
    if ($Profile -eq "ask") {
        Write-Host ""
        Write-Host "Choose the default output format for this workstation:"
        Write-Host "  1) 4:3      1440x1080  finance/business/knowledge explainer"
        Write-Host "  2) vertical 1080x1920  Douyin/TikTok/Reels/Shorts"
        Write-Host "  3) horizontal 1920x1080 Bilibili/YouTube/course/tutorial"
        Write-Host "  4) source   keep source aspect ratio"
        $choice = Read-Host "Enter 1, 2, 3, or 4"
        switch ($choice) {
            "1" { return "4x3" }
            "2" { return "vertical" }
            "3" { return "horizontal" }
            "4" { return "source" }
            default { return "4x3" }
        }
    }
    return $Profile
}

function Get-TargetFormat([string]$Profile) {
    switch ($Profile) {
        "4x3" {
            return [ordered]@{
                profile = "4x3"
                aspect_ratio = "4:3"
                width = 1440
                height = 1080
                fps = 30
                description = "4:3 horizontal explainer format"
            }
        }
        "vertical" {
            return [ordered]@{
                profile = "vertical"
                aspect_ratio = "9:16"
                width = 1080
                height = 1920
                fps = 30
                description = "vertical short-form format"
            }
        }
        "horizontal" {
            return [ordered]@{
                profile = "horizontal"
                aspect_ratio = "16:9"
                width = 1920
                height = 1080
                fps = 30
                description = "horizontal tutorial/course format"
            }
        }
        "source" {
            return [ordered]@{
                profile = "source"
                aspect_ratio = "source"
                width = $null
                height = $null
                fps = 30
                description = "keep source aspect ratio"
            }
        }
    }
}

function Write-WorkflowConfig([string]$ProjectRoot, [object]$Format, [string]$InputDir, [string]$OutputDir, [string]$BgmDir, [string]$ReportsDir, [string]$ToolsDir, [string]$VenvDir) {
    $config = [ordered]@{
        schema = "codex-auto-video-editing-workflow-config-v1"
        target = $Format
        paths = [ordered]@{
            project_root = $ProjectRoot
            input_dir = $InputDir
            output_dir = $OutputDir
            bgm_dir = $BgmDir
            reports_dir = $ReportsDir
            tools_dir = $ToolsDir
            venv_dir = $VenvDir
        }
        install_policy = [ordered]@{
            silent_install = $false
            require_user_approval_for_downloads = $true
        }
    }
    $configPath = Join-Path $ProjectRoot "workflow-config.json"
    $config | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $configPath -Encoding UTF8
    return $configPath
}

if (-not $ProjectRoot) { $ProjectRoot = Resolve-DefaultProjectRoot }
if (-not $InputDir) { $InputDir = Join-Path $ProjectRoot "input" }
if (-not $OutputDir) { $OutputDir = Join-Path $ProjectRoot "output" }
if (-not $BgmDir) { $BgmDir = Join-Path $ProjectRoot "bgm" }
if (-not $ReportsDir) { $ReportsDir = Join-Path $ProjectRoot "reports" }
if (-not $ToolsDir) { $ToolsDir = Join-Path $ProjectRoot "tools" }
if (-not $VenvDir) { $VenvDir = Join-Path $ProjectRoot ".venv" }

Ensure-Directory $ProjectRoot
Ensure-Directory $InputDir
Ensure-Directory $OutputDir
Ensure-Directory $BgmDir
Ensure-Directory $ReportsDir
Ensure-Directory $ToolsDir

$resolvedTargetProfile = Resolve-TargetProfile $TargetProfile
$targetFormat = Get-TargetFormat $resolvedTargetProfile
$configPath = Write-WorkflowConfig $ProjectRoot $targetFormat $InputDir $OutputDir $BgmDir $ReportsDir $ToolsDir $VenvDir

$pathFfmpeg = Find-CommandPath "ffmpeg"
$localFfmpeg = Get-LocalFfmpegPath $ToolsDir
if (-not $pathFfmpeg -and -not (Test-Path -LiteralPath $localFfmpeg -PathType Leaf)) {
    if ($DownloadFfmpeg) {
        $localFfmpeg = Install-Ffmpeg $ToolsDir
    }
}

$venvPython = $null
if ($CreateVenv -or $InstallPythonPackages) {
    $venvPython = Ensure-Venv $VenvDir
}
if ($InstallPythonPackages) {
    Install-PythonPackages $venvPython ([bool]$WithTranscription)
}

[PSCustomObject]@{
    ProjectRoot = $ProjectRoot
    InputDir = $InputDir
    OutputDir = $OutputDir
    BgmDir = $BgmDir
    ReportsDir = $ReportsDir
    ToolsDir = $ToolsDir
    WorkflowConfig = $configPath
    TargetProfile = $targetFormat.profile
    TargetAspectRatio = $targetFormat.aspect_ratio
    TargetWidth = $targetFormat.width
    TargetHeight = $targetFormat.height
    TargetFps = $targetFormat.fps
    VenvPython = $venvPython
    FfmpegOnPath = $pathFfmpeg
    LocalFfmpeg = if (Test-Path -LiteralPath $localFfmpeg -PathType Leaf) { $localFfmpeg } else { $null }
    PythonPackagesInstalled = [bool]$InstallPythonPackages
    TranscriptionPackagesInstalled = [bool]$WithTranscription
}
