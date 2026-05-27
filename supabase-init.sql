-- Supabase initialization SQL for Gym-portal
-- Enables UUID generation and creates customers and payments tables

-- Enable UUID generation
create extension if not exists "pgcrypto";

-- customers table
create table if not exists customers (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  phone_number text unique not null,
  address text,
  package_info text,
  created_at timestamptz default now()
);

create index if not exists idx_customers_phone on customers(phone_number);
create index if not exists idx_customers_name on customers(name);

-- payments table
create table if not exists payments (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid references customers(id) on delete cascade,
  amount_paid numeric(10,2) not null,
  payment_date timestamptz default now(),
  payment_status text
);

create index if not exists idx_payments_customer on payments(customer_id);
create index if not exists idx_payments_date on payments(payment_date);

-- Example Row Level Security (RLS) policies
-- NOTE: Adjust these policies to your deployment model. The static client uses the anon key,
-- so to require authenticated admin users you should enable Supabase Auth and then adapt policies.

-- Enable RLS on tables (optional)
-- ALTER TABLE customers ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE payments ENABLE ROW LEVEL SECURITY;

-- Example policy allowing only authenticated users to select rows (uncomment to apply)
-- CREATE POLICY "Allow authenticated select" ON customers
-- FOR SELECT USING (auth.role() = 'authenticated');

-- Example policy allowing authenticated inserts
-- CREATE POLICY "Allow authenticated insert" ON customers
-- FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- Example: restrict writes to a specific admin email (replace with your admin email)
-- CREATE POLICY "Admins can modify" ON customers
-- FOR ALL USING (auth.token() ->> 'email' = 'admin@example.com');

-- After creating policies, test them carefully in Supabase.

-- ------------------------------------------------------------------
-- Admins table + practical RLS policies (safe for production once Auth used)
-- ------------------------------------------------------------------

-- admins table to list admin emails (used by RLS policies)
create table if not exists admins (
  id uuid primary key default gen_random_uuid(),
  email text unique not null,
  created_at timestamptz default now()
);

-- Insert the admin email you provided (no-op if already exists)
insert into admins (email) values ('auraelite.fit2026@gmail.com') on conflict (email) do nothing;

-- Enable Row Level Security on the main tables
alter table customers enable row level security;
alter table payments enable row level security;

-- Allow any authenticated user to read customers/payments
create policy "authenticated_select_customers" on customers
  for select using (auth.role() = 'authenticated');

create policy "authenticated_select_payments" on payments
  for select using (auth.role() = 'authenticated');

-- Allow only emails present in `admins` table to insert/update/delete (full access)
-- Drop existing policies if present to allow re-running this script safely
drop policy if exists "admins_modify_customers" on customers;
drop policy if exists "admins_modify_payments" on payments;

-- Use JWT claims from the request to check admin email.
-- Supabase exposes JWT claims via the request setting `request.jwt.claims`.
-- We extract the email with: (current_setting('request.jwt.claims', true)::json ->> 'email')

create policy "admins_modify_customers" on customers
  for all using (
    exists (
      select 1 from admins where admins.email = (current_setting('request.jwt.claims', true)::json ->> 'email')
    )
  );

create policy "admins_modify_payments" on payments
  for all using (
    exists (
      select 1 from admins where admins.email = (current_setting('request.jwt.claims', true)::json ->> 'email')
    )
  );

-- NOTES:
-- 1) Create an Auth user in Supabase for the admin email (Auth → Users) with the password you provided.
-- 2) The frontend must sign in via Supabase Auth to obtain an authenticated session (so auth.role() = 'authenticated').
-- 3) If you need temporary open access for testing, comment out the ALTER TABLE ... ENABLE ROW LEVEL SECURITY lines.

