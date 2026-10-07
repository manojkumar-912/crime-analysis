# Antigravity Deployment Script for Crime Analysis System

Write-Host "--- Starting Antigravity Deployment ---" -ForegroundColor Cyan

# 1. Build Frontend
Write-Host "Building frontend..." -ForegroundColor Yellow
cd client
npm.cmd run build

if ($LASTEXITCODE -ne 0) {
    Write-Host "Frontend build failed!" -ForegroundColor Red
    exit $LASTEXITCODE
}

# 2. Prepare Dist
Write-Host "Preparing deployment package..." -ForegroundColor Yellow
cd ..
if (Test-Path -Path "dist") { Remove-Item -Path "dist" -Recurse -Force }
New-Item -ItemType Directory -Path "dist"
Copy-Item -Path "client/dist/*" -Destination "dist" -Recurse

# 3. Final Summary
Write-Host "Deployment package created in /dist" -ForegroundColor Green
Write-Host "System is ready for production-level preview under Antigravity infrastructure." -ForegroundColor Cyan
Write-Host "--- Deployment Complete ---" -ForegroundColor Green
