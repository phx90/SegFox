Write-Host "🚀 Iniciando servidor com TailwindCSS + Rails..."

Start-Process powershell -ArgumentList "ruby bin\rails server"
Start-Process powershell -ArgumentList "npx tailwindcss -i ./app/assets/stylesheets/application.tailwind.css -o ./app/assets/builds/application.css --watch"
