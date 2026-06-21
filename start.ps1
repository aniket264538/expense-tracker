# Activate virtual environment and start the Flask app
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$activateScript = Join-Path $scriptDir "venv\Scripts\Activate.ps1"

if (-not (Test-Path $activateScript)) {
    Write-Error "Virtual environment not found. Run: python -m venv venv && .\venv\Scripts\pip install -r requirements.txt"
    exit 1
}

. $activateScript
Write-Host "Virtual environment activated: $($env:VIRTUAL_ENV)"
Write-Host "Starting Spendly on http://localhost:5001 ..."
python "$scriptDir\app.py"
