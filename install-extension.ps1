$ExtensionName = "atomic-agents"
$SourcePath = Join-Path $PSScriptRoot "extensions"
$GlobalExtensionsDir = "$HOME\.gemini\extensions"
$TargetDir = "$GlobalExtensionsDir\$ExtensionName"

if (-not (Test-Path -Path $SourcePath)) {
    Write-Error "Extensions directory not found at $SourcePath"
    exit 1
}

Write-Host "Installing '$ExtensionName' extension..." -ForegroundColor Cyan

if (-not (Test-Path -Path $GlobalExtensionsDir)) {
    New-Item -ItemType Directory -Force -Path $GlobalExtensionsDir | Out-Null
    Write-Host "Created global extensions directory: $GlobalExtensionsDir"
}

if (Test-Path -Path $TargetDir) {
    Write-Warning "Extension '$ExtensionName' already exists at $TargetDir."
    $confirm = Read-Host "Overwrite? (y/n)"
    if ($confirm -ne 'y') {
        Write-Host "Installation cancelled."
        exit
    }
    Remove-Item -Path $TargetDir -Recurse -Force
}

New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null
Write-Host "Copying files from $SourcePath to $TargetDir..."

Get-ChildItem -Path $SourcePath | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $TargetDir -Recurse -Force
}

Write-Host "`nSuccess! Extension installed." -ForegroundColor Green
Write-Host "To verify it is running, you can run:" -ForegroundColor Gray
Write-Host "  /extensions list" -ForegroundColor Yellow
Write-Host "  /atomic-agents help" -ForegroundColor Yellow
Write-Host "`nYou may need to restart your Gemini session or run /refresh to pick up the new extension." -ForegroundColor Gray