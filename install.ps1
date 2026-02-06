param(
    [switch]$Debug
)

$ErrorActionPreference = "Stop"

function Update-JsonFile {
    param(
        [string]$SourceFile,
        [string]$TargetFile,
        [string]$Description
    )

    Write-Host "Updating $Description..." -ForegroundColor Blue

    if (-not (Test-Path $SourceFile)) {
        Write-Warning "Source file $SourceFile not found. Skipping update."
        return
    }

    try {
        $jsonupdate = Get-Content $SourceFile -Raw -Encoding UTF8 | ConvertFrom-Json
    } catch {
        Write-Error "Failed to parse source JSON from $SourceFile"
        return
    }

    if (Test-Path $TargetFile) {
        try {
            $Settings = Get-Content $TargetFile -Raw -Encoding UTF8 | ConvertFrom-Json
        } catch {
            Write-Warning "Failed to parse target JSON $TargetFile. Starting fresh."
            $Settings = [PSCustomObject]@{}
        }
    } else {
        $Settings = [PSCustomObject]@{}
    }

    foreach ($prop in $jsonupdate.PSObject.Properties) {
        Add-Member -InputObject $Settings -MemberType NoteProperty -Name $prop.Name -Value $prop.Value -Force
    }

    $finalJson = $Settings | ConvertTo-Json -Depth 100
    
    $parentDir = Split-Path $TargetFile -Parent
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    [System.IO.File]::WriteAllText($TargetFile, $finalJson, (New-Object System.Text.UTF8Encoding $false))
    Write-Host "$Description updated successfully." -ForegroundColor Green
}

$GeminiRoot = "$HOME\.gemini"
$ExtensionsRoot = Join-Path $GeminiRoot "extensions"
$SourceExtensions = Join-Path $PSScriptRoot "extensions"

Write-Host "Installing Atomic Agents Scaffolder Extension..." -ForegroundColor Blue

if (-not (Test-Path $SourceExtensions)) {
    Write-Error "Source extensions directory '$SourceExtensions' not found."
    exit 1
}

if (-not (Test-Path $ExtensionsRoot)) {
    New-Item -ItemType Directory -Path $ExtensionsRoot -Force | Out-Null
}

Get-ChildItem $SourceExtensions -Directory | ForEach-Object {
    Write-Host "Installing extension: $($_.Name)" -ForegroundColor Cyan
    Copy-Item -Path $_.FullName -Destination $ExtensionsRoot -Recurse -Force
}

$EnablementFile = Join-Path $ExtensionsRoot "extension-enablement.json"
$EnablementSource = Join-Path $PSScriptRoot "extension-enablement.json"
Update-JsonFile -SourceFile $EnablementSource -TargetFile $EnablementFile -Description "extension-enablement.json"

Write-Host "`nInstallation Complete!" -ForegroundColor Green
Write-Host "Run /refresh in Gemini to activate the extension." -ForegroundColor Yellow