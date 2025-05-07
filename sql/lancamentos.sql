-- Tabela de Lançamentos Financeiros
create table lancamentos(
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users on delete cascade,
  tipo text check (tipo in ('receita','despesa')),
  categoria text,
  valor numeric not null check (valor >= 0),
  descricao text,
  data_ocorrencia date not null,
  data_vencimento date,
  created_at timestamp with time zone default timezone('utc'::text, now())
);
--Habilitar segurança do supabase
alter table lancamentos enable row level security;
--Política para cada usuário somente ver os seus próprios lançamentos
create policy "Permitir acesso ao próprio usuário no lançamento"
on lancamentos for all
using (auth.uid() = user_id)
with check (auth.uid() = user_id);