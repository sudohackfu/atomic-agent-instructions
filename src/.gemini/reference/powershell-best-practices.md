# PowerShell Best Practices Reference

A guide for writing consistent, maintainable, and safe PowerShell scripts based on Microsoft and community standards.

---

## 1. Error Handling Standards
- **Structured Error Handling:** Use \Try-Catch-Finally\ for all risky operations.
- **Terminating vs. Non-Terminating Errors:** PowerShell defaults to non-terminating errors (which don't trigger \catch\).
- **Force Termination:** Use \-ErrorAction Stop\ or set \$ErrorActionPreference = 'Stop'\ to ensure errors are caught.
- **Cleanup:** Use \Finally\ for tasks that must run regardless of success or failure (e.g., closing file handles).

`powershell
try {
    # Force terminating error
    Copy-Item -Path $source -Destination $dest -ErrorAction Stop
} catch [System.IO.IOException] {
    Write-Error "IO Error: $(_)"
} catch {
    Write-Error "Unexpected Error: $(_)"
} finally {
    # Runs always
}
`

## 2. Naming Conventions
- **Verb-Noun Format:** Use standard \Verb-Noun\ format for all functions (e.g., \Get-ProjectInfo\). Use \Get-Verb\ to find approved verbs.
- **PascalCase:** Use **PascalCase** for functions, parameters, and variable names.
- **Singular Nouns:** Prefer singular nouns for parameters (e.g., \-Name\ instead of \-Names\).
- **Avoid Aliases:** Never use aliases (e.g., \ls\, \%\, \?\) in scripts; use full cmdlet names (\Get-ChildItem\, \ForEach-Object\, \Where-Object\).

## 3. Code Structure & Readability
- **Cmdlet Binding:** Enable \[CmdletBinding()]\ to support common parameters like \-Verbose\ and \-Debug\.
- **Strict Mode:** Use \Set-StrictMode -Version Latest\ to prevent common scripting errors (e.g., using uninitialized variables).
- **Splatting:** Use splatting for commands with many parameters to improve readability.
- **Path Handling:** Always use \Join-Path\ to build file paths; never use manual string concatenation.

`powershell
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [string]ProjectRoot
)
Set-StrictMode -Version Latest

$params = @{
    Path        = (Join-Path -Path $ProjectRoot -ChildPath "config.json")
    Force       = $true
    ErrorAction = "Stop"
}
Remove-Item @params
`

## 4. Design Guidelines
- **Pipeline Support:** Design functions to accept and produce pipeline input.
- **Feedback:** Use \Write-Warning\, \Write-Verbose\, and \Write-Debug\ instead of \Write-Host\ for non-essential output.
- **Documentation:** Include comment-based help (\.SYNOPSIS\, \.DESCRIPTION\) for all scripts and functions.

## 5. Security & Safety
- **Validate Input:** Use validation attributes (e.g., \[ValidateSet()]\, \[ValidateNotNullOrEmpty()]\) on parameters.
- **Safe Execution:** Avoid \Invoke-Expression\ with unvalidated strings.
- **WhatIf Support:** Implement \SupportsShouldProcess\ for destructive actions.