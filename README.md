# Dieta & Treinos — MVP

Base funcional inicial em **Next.js + Prisma** para evoluir o sistema de:
- alimentos;
- refeições;
- treinos;
- medidas corporais.

## Módulo vertical pronto: Alimentos
- Listagem em `/foods`.
- Cadastro em `/foods/new`.
- API:
  - `GET /api/foods?userId=...`
  - `POST /api/foods`
  - `DELETE /api/foods/:id`
- Validação de payload com Zod.

## Migração inicial
- Arquivo de migração SQL criado em:
  - `prisma/migrations/20260510124500_init/migration.sql`

## Configuração
1. Instale dependências:
   ```bash
   npm install
   ```
2. Configure `.env`:
   ```env
   DATABASE_URL="postgresql://USER:PASSWORD@localhost:5432/dieta"
   ```
3. Rode migrações:
   ```bash
   npx prisma migrate dev --name init
   npx prisma generate
   ```
4. Inicie o projeto:
   ```bash
   npm run dev
   ```

## Exemplo de criação de alimento
```bash
curl -X POST http://localhost:3000/api/foods \
  -H "Content-Type: application/json" \
  -d '{
    "userId":"demo-user",
    "name":"Arroz",
    "unit":"g",
    "category":"CARB"
  }'
```
