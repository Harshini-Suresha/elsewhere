-- Run once in Supabase: SQL Editor > New query > paste > Run
create table entries(id bigint generated always as identity primary key, d date not null default current_date, t text not null, b text default '', tag text default 'drive-by', u text, img text, w int, h int, k text);
create table seats(id bigint generated always as identity primary key, email text not null, at timestamptz default now());
alter table entries enable row level security;
alter table seats enable row level security;
create policy "anyone reads entries" on entries for select using (true);
create policy "only me writes entries" on entries for all to authenticated using (true) with check (true);
create policy "anyone joins list" on seats for insert with check (true);
create policy "only me reads list" on seats for select to authenticated using (true);
insert into storage.buckets(id,name,public) values('covers','covers',true);
create policy "covers readable" on storage.objects for select using (bucket_id='covers');
create policy "only me uploads covers" on storage.objects for insert to authenticated with check (bucket_id='covers');
