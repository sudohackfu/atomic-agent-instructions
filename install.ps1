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

    # Read source updates
    if (-not (Test-Path $SourceFile)) {
        Write-Warning "Source file $SourceFile not found. Skipping $Description update."
        return
    }

    $jsonupdate = @(Get-Content $SourceFile -Raw -Encoding UTF8)
    if ($Debug) {
        Write-Host "DEBUG: Raw $Description source content:" -ForegroundColor Cyan
        Write-Host $jsonupdate -ForegroundColor Yellow
    }

    try {
        $jsonupdate_obj = $jsonupdate | ConvertFrom-Json
    } catch {
        Write-Error "Failed to parse source JSON from $SourceFile"
        return
    }

    # Read existing target or create empty
    if (Test-Path $TargetFile) {
        try {
            $JsonContent = @(Get-Content $TargetFile -Raw -Encoding UTF8)
            $Settings = $JsonContent | ConvertFrom-Json
            Write-Host "Found existing $Description" -ForegroundColor Yellow
        } catch {
            Write-Warning "Failed to parse target JSON $TargetFile. Starting fresh."
            $Settings = [PSCustomObject]@{}
        }
    } else {
        $Settings = [PSCustomObject]@{}
        Write-Host "Creating new $Description..." -ForegroundColor Green
    }

    # Merge updates
    foreach ($prop in $jsonupdate_obj.PSObject.Properties) {
        $existingValue = $Settings.$($prop.Name)
        $newValue = $prop.Value
        $existingJson = if ($null -ne $existingValue) { $existingValue | ConvertTo-Json -Depth 10 -Compress } else { $null }
        $newJson = $newValue | ConvertTo-Json -Depth 10 -Compress

        if ($existingJson -ne $newJson) {
            Add-Member -InputObject $Settings -MemberType NoteProperty -Name $prop.Name -Value $newValue -Force
            Write-Host "Updated $($prop.Name)" -ForegroundColor Gray
        } else {
            Write-Host "$($prop.Name) already up to date" -ForegroundColor Gray
        }
    }

    # Format and save
    $finalJson = $Settings | ConvertTo-Json -Depth 10 -Compress
    
    # Pretty print logic
    $indentedJson = ($finalJson | ConvertFrom-Json) | ConvertTo-Json -Depth 100
    $indentation = 2
    $indent = 0
    $regexUnlessQuoted = '(?=([^"]*"[^"]*")*[^"]*$)'
    $result = $indentedJson -split '\r?\n' |
        ForEach-Object {
            if ($_ -match "[}\]]$regexUnlessQuoted") {
                $indent = [Math]::Max($indent - $indentation, 0)
            }
            $line = (' ' * $indent) + ($_.TrimStart() -replace ":\s+$regexUnlessQuoted", ': ')
            if ($_ -match "[\{\[]$regexUnlessQuoted") {
                $indent += $indentation
            }
            $line
        }
    $completeResult = $result -Join [Environment]::NewLine
    $completeResult = $completeResult -replace "\[\s*\]$regexUnlessQuoted", '[]'
    $completeResult = $completeResult -replace "\{\s*\}$regexUnlessQuoted", '{}'
    $finalJson = $completeResult

    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    
    # Ensure directory exists
    $parentDir = Split-Path $TargetFile -Parent
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    [System.IO.File]::WriteAllText($TargetFile, $finalJson, $utf8NoBom)
    Write-Host "$Description updated successfully." -ForegroundColor Green
}

$GeminiRoot = "$HOME\.gemini"
$SourceRoot = "$PSScriptRoot\src\.gemini"

Write-Host "Installing Atomic Agents Extension..." -ForegroundColor Blue

# 1. Copy Files
Write-Host "Copying extension files..." -ForegroundColor Blue
if (-not (Test-Path $SourceRoot)) {
    Write-Error "Source directory '$SourceRoot' not found. Please run this script from the repository root."
    exit 1
}

# First, create all missing directories
Get-ChildItem $SourceRoot -Recurse | Where-Object { $_.PSIsContainer } | ForEach-Object {
    $relativePath = $_.FullName.Substring($SourceRoot.Length + 1)
    $destPath = Join-Path $GeminiRoot $relativePath
    if (-not (Test-Path $destPath)) {
        New-Item -ItemType Directory -Path $destPath -Force | Out-Null
    }
}

# Then, copy all missing files or update them
Get-ChildItem $SourceRoot -Recurse | Where-Object { -not $_.PSIsContainer } | ForEach-Object {
    $relativePath = $_.FullName.Substring($SourceRoot.Length + 1)
    $destPath = Join-Path $GeminiRoot $relativePath
    
    # Always copy to ensure updates are applied
    Copy-Item $_.FullName $destPath -Force
}
Write-Host "Files copied successfully." -ForegroundColor Green

# 2. Update Configuration Files
$ExtensionEnablementFile = "$GeminiRoot\extensions\extension-enablement.json"
$ExtensionEnablementSource = "$PSScriptRoot\extension-enablement.json"
Update-JsonFile -SourceFile $ExtensionEnablementSource -TargetFile $ExtensionEnablementFile -Description "extension-enablement.json"

# 3. Post-Install Instructions
Write-Host "`nInstallation Complete!" -ForegroundColor Green
Write-Host "`nIMPORTANT NEXT STEPS:" -ForegroundColor Yellow
Write-Host "1. Restart your Gemini session or run /refresh to pick up the new extension." -ForegroundColor White
