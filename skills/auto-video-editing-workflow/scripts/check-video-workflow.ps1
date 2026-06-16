param(
    [string]$ProjectRoot = "",
    [string]$SkillRoot = "",
    [string]$InputDir = "",
    [string]$OutputDir = "",
    [string]$BgmDir = "",
    [string]$ReportsDir = ""
)

function Resolve-DefaultProjectRoot {
    return (Join-Path $env:USERPROFILE "auto-video-editing-workflow")
}

function Resolve-DefaultSkillRoot {
    return (Join-Path $env:USERPROFILE ".codex\skills\auto-video-editing-workflow")
}

function Find-CommandPath([string]$Name) {
    $cmd = Get-Command $Name -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($cmd) { return $cmd.Source }
    return $null
}

if (-not $ProjectRoot) { $ProjectRoot = Resolve-DefaultProjectRoot }
if (-not $SkillRoot) { $SkillRoot = Resolve-DefaultSkillRoot }
if (-not $InputDir) { $InputDir = Join-Path $ProjectRoot "input" }
if (-not $OutputDir) { $OutputDir = Join-Path $ProjectRoot "output" }
if (-not $BgmDir) { $BgmDir = Join-Path $ProjectRoot "bgm" }
if (-not $ReportsDir) { $ReportsDir = Join-Path $ProjectRoot "reports" }

$ConfigPath = Join-Path $ProjectRoot "workflow-config.json"

$items = @(
    @{ Label = "Project root"; Path = $ProjectRoot; Type = "Directory" },
    @{ Label = "Installed skill root"; Path = $SkillRoot; Type = "Directory" },
    @{ Label = "Input folder"; Path = $InputDir; Type = "Directory" },
    @{ Label = "Output folder"; Path = $OutputDir; Type = "Directory" },
    @{ Label = "BGM folder"; Path = $BgmDir; Type = "Directory" },
    @{ Label = "Reports folder"; Path = $ReportsDir; Type = "Directory" },
    @{ Label = "Workflow config"; Path = $ConfigPath; Type = "File" },
    @{ Label = "Skill entry"; Path = (Join-Path $SkillRoot "SKILL.md"); Type = "File" },
    @{ Label = "Skill workflow reference"; Path = (Join-Path $SkillRoot "references\workflow.md"); Type = "File" },
    @{ Label = "Skill style rules"; Path = (Join-Path $SkillRoot "references\style-rules.md"); Type = "File" },
    @{ Label = "Skill local setup"; Path = (Join-Path $SkillRoot "references\local-setup.md"); Type = "File" },
    @{ Label = "Skill setup script"; Path = (Join-Path $SkillRoot "scripts\setup-video-workflow.ps1"); Type = "File" },
    @{ Label = "smart_talk_editor.py"; Path = (Join-Path $ProjectRoot "code\scripts\smart_talk_editor.py"); Type = "File" },
    @{ Label = "stock_material_api.py"; Path = (Join-Path $ProjectRoot "code\scripts\stock_material_api.py"); Type = "File" },
    @{ Label = "ffmpeg.exe"; Path = (Join-Path $ProjectRoot "tools\ffmpeg\bin\ffmpeg.exe"); Type = "File" },
    @{ Label = "venv python"; Path = (Join-Path $ProjectRoot ".venv\Scripts\python.exe"); Type = "File" }
)

foreach ($item in $items) {
    $exists = if ($item.Type -eq "Directory") {
        Test-Path -LiteralPath $item.Path -PathType Container
    } else {
        Test-Path -LiteralPath $item.Path -PathType Leaf
    }
    [PSCustomObject]@{
        Label = $item.Label
        Exists = $exists
        Path = $item.Path
    }
}

[PSCustomObject]@{
    Label = "ffmpeg on PATH"
    Exists = [bool](Find-CommandPath "ffmpeg")
    Path = Find-CommandPath "ffmpeg"
}

[PSCustomObject]@{
    Label = "python on PATH"
    Exists = [bool](Find-CommandPath "python")
    Path = Find-CommandPath "python"
}

if (Test-Path -LiteralPath $ConfigPath -PathType Leaf) {
    try {
        $config = Get-Content -LiteralPath $ConfigPath -Raw -Encoding UTF8 | ConvertFrom-Json
        [PSCustomObject]@{
            Label = "Configured target profile"
            Exists = $true
            Path = ("{0} {1}x{2} {3}fps" -f $config.target.aspect_ratio, $config.target.width, $config.target.height, $config.target.fps)
        }
    } catch {
        [PSCustomObject]@{
            Label = "Configured target profile"
            Exists = $false
            Path = "workflow-config.json exists but could not be parsed"
        }
    }
}
