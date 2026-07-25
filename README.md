# SegFox

Catálogo responsivo de cães das raças Terrier Brasileiro e Pastor da Mantiqueira, com área administrativa protegida para cadastro, imagens, disponibilidade e genealogia.

## Funcionalidades

- Catálogo público com busca por nome e filtro por raça.
- Páginas institucionais e páginas específicas por raça.
- Detalhes, galeria de até quatro imagens, QR Code e árvore genealógica.
- Login administrativo e CRUD protegido.
- Paginação do catálogo em grupos de 12 cães.
- Upload validado (JPEG, PNG ou WebP, até 5 MB por arquivo).
- Seeds idempotentes e suíte de testes Rails.

## Tecnologias

Ruby 3.4.2, Rails 8.0.2, PostgreSQL, Hotwire, Tailwind CSS, Active Storage, Devise, Minitest e Docker.

## Pré-requisitos

- Ruby 3.4.2 e Bundler
- Node.js 20+ e npm
- PostgreSQL 16+ ou Docker
- libvips e Chrome/Chromium

No Windows, instale também as bibliotecas usadas pela gem `pg`:

```powershell
ridk exec pacman -S mingw-w64-ucrt-x86_64-postgresql
```

## Instalação local

```powershell
Copy-Item .env.example .env
docker compose up -d db
bundle install
npm ci
bin/rails db:prepare
bin/rails db:seed
bin/dev
```

A aplicação fica em `http://localhost:3000`. Preencha `SEED_ADMIN_PASSWORD` no `.env` antes do seed para criar o administrador local. O seed não apaga registros.
O PostgreSQL do Compose é publicado em `localhost:5433` para não conflitar com instalações locais.

## Variáveis de ambiente

Para armazenamento externo, defina `ACTIVE_STORAGE_SERVICE=amazon` e preencha as variáveis `AWS_*`. O endpoint configurável também permite serviços compatíveis com S3.

Para recuperação de senha por e-mail, configure `APP_HOST`, `MAILER_FROM` e as variáveis `SMTP_*`. Sem `SMTP_ADDRESS`, nenhuma conexão SMTP é tentada.

## Testes e qualidade

```powershell
bin/rails db:test:prepare
bin/rails test
bin/rails test:system
bin/rubocop
bin/brakeman --no-pager
npm audit
npm run build
```

## Docker

O `compose.yml` inicia o PostgreSQL de desenvolvimento com healthcheck:

```powershell
docker compose up -d db
docker compose ps
```

O `Dockerfile` gera a imagem de produção:

```powershell
docker build -t segfox .
docker run --rm -p 80:80 --env-file .env -e RAILS_MASTER_KEY=... segfox
```

## Estrutura

- `app/controllers`: catálogo, sessão e administração.
- `app/models`: domínio, validações e relacionamentos.
- `app/views`: interface ERB responsiva.
- `db/migrate`: schema e integridade referencial.
- `db/seeds.rb`: dados iniciais idempotentes.
- `test`: testes de modelo, requisição e sistema.
