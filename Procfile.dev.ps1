Write-Host "🚀 Iniciando servidor com TailwindCSS + Rails..."

Start-Process powershell -ArgumentList "bundle exec rails server"
Start-Process powershell -ArgumentList "npm run dev:css"
