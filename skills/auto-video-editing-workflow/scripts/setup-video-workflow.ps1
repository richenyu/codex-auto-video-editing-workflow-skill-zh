param(
    [string]$ProjectRoot = "",
    [string]$InputDir = "",
    [string]$OutputDir = "",
    [string]$BgmDir = "",
    [string]$ToolsDir = "",
    [string]$VenvDir = "",
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

if (-not $ProjectRoot) { $ProjectRoot = Resolve-DefaultProjectRoot }
if (-not $InputDir) { $InputDir = Join-Path $ProjectRoot "input" }
if (-not $OutputDir) { $OutputDir = Join-Path $ProjectRoot "output" }
if (-not $BgmDir) { $BgmDir = Join-Path $ProjectRoot "bgm" }
if (-not $ToolsDir) { $ToolsDir = Join-Path $ProjectRoot "tools" }
if (-not $VenvDir) { $VenvDir = Join-Path $ProjectRoot ".venv" }

Ensure-Directory $ProjectRoot
Ensure-Directory $InputDir
Ensure-Directory $OutputDir
Ensure-Directory $BgmDir
Ensure-Directory $ToolsDir

$pathFfmpeg = Find-CommandPath "ffmpeg"
$localFfmpeg = Get-LocalFfmpegPath $ToolsDir
if (-not $pathFfmpeg -and -not (Test-Path -LiteralPath $localFfmpeg -PathType Leaf)) {
    if ($DownloadFfmpeg) {
        $localFfmpeg = Install-Ffmpeg $ToolsDir
    }
}

$venvPython = Ensure-Venv $VenvDir
if ($InstallPythonPackages) {
    Install-PythonPackages $venvPython ([bool]$WithTranscription)
}

[PSCustomObject]@{
    ProjectRoot = $ProjectRoot
    InputDir = $InputDir
    OutputDir = $OutputDir
    BgmDir = $BgmDir
    ToolsDir = $ToolsDir
    VenvPython = $venvPython
    FfmpegOnPath = $pathFfmpeg
    LocalFfmpeg = if (Test-Path -LiteralPath $localFfmpeg -PathType Leaf) { $localFfmpeg } else { $null }
    PythonPackagesInstalled = [bool]$InstallPythonPackages
    TranscriptionPackagesInstalled = [bool]$WithTranscription
}
