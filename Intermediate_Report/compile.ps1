# Configurations
$groupNumber = "10"
$milestone = "3"
$texFile = "intermediate_report.tex"
$pdfFile = "intermediate_report.pdf"

# Set location to the script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if ($scriptDir) {
    Set-Location $scriptDir
}

Write-Host "Starting LaTeX compilation for Group $groupNumber, Milestone $milestone..."

# Run latexmk
& latexmk -pdf -interaction=nonstopmode $texFile

# Check if the PDF file exists
if (Test-Path $pdfFile) {
    $dateStr = Get-Date -Format "yyyyMMdd"
    $destFilename = "Group${groupNumber}_Milestone_${milestone}_${dateStr}.pdf"
    
    Copy-Item $pdfFile $destFilename -Force
    Write-Host "`n[SUCCESS] PDF compiled/found and copied to: $destFilename" -ForegroundColor Green
} else {
    Write-Host "`n[ERROR] $pdfFile was not found. Compilation might have failed." -ForegroundColor Red
}
