Write-Host "🚀 Iniciando servidor com TailwindCSS + Rails..."

Start-Process powershell -ArgumentList "ruby bin\rails server"
Start-Process powershell -ArgumentList "npm run dev:css"
