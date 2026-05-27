# Gym-portal — CRM Dashboard

This project is a static single-page Gym CRM dashboard built with HTML, Tailwind CSS (CDN), and Vanilla JavaScript. It connects directly to a Supabase (Postgres) backend using the Supabase JavaScript client.

## What this includes
- `crm-dashboard.html` — Single-file CRM app with a configuration overlay to enter Supabase URL & Anon Key, and a simple admin login.
- `supabase-init.sql` — SQL to create the `customers` and `payments` tables and example Row-Level Security (RLS) policy snippets.

## Quick setup

1. Create a free Supabase project at https://supabase.com and open the project.
2. Open **SQL Editor** → paste the contents of `supabase-init.sql` and run it to create tables and indexes.
3. In the Supabase dashboard go to Project Settings → API. Copy the **Project URL** and the **anon public** key.
4. Open `crm-dashboard.html` in a browser (or host on GitHub Pages). Click **Config**, paste the Supabase URL and Anon Key, and set an admin username and password. Save.
5. Click **Login** and sign in using the admin credentials you set.

## Supabase SQL
Use the `supabase-init.sql` file included in this repo. It creates the `customers` and `payments` tables with sensible indexes and includes example RLS policies you can adapt.

## Security notes
- The app uses the Supabase Anon Key for client-side access. For production, restrict data access using Supabase Row Level Security (RLS) and Auth (recommended).
- Currently the admin login in the UI stores a hashed password in `localStorage`. This is a simple convenience for a static-only admin flow and is not a secure replacement for server-side authentication.
- For a more secure deployment, enable Supabase Auth and create an admin user, then update the front-end to sign-in via Supabase Auth and enforce RLS policies that allow operations only for authenticated admin users.

## Deploy to GitHub Pages
1. Commit the repository to GitHub.
2. In your repository settings enable GitHub Pages from the `main` branch (or `gh-pages`).
3. Visit `https://<your-username>.github.io/<repo>/crm-dashboard.html` to open the CRM (or add a simple index redirect).

## Next steps I can help with
- Implement Supabase Auth sign-in flow and update the UI to use authenticated sessions.
- Add RLS policies that restrict writes to admin users (example included in `supabase-init.sql`).
- Add automated tests or a simple backend proxy for admin-only service-role writes.

Feel free to tell me which of the next steps you'd like me to implement.
# Aura Elite Fitness Portal

A modern static gym website portal for Aura Elite Fitness built with HTML, CSS, and JavaScript.

## Pages

- `index.html` — Home page with hero, about section, membership preview, and CRM dashboard introduction.
- `membership.html` — Membership plan details and benefits.
- `crm-dashboard.html` — CRM dashboard mockup for gym operations and member analytics.

## Assets

- `assets/hero.svg`
- `assets/gym-workout.svg`
- `assets/dashboard.svg`
- `assets/welcome.gif`
- `assets/motivate.gif`
- `assets/whatsapp.gif`

## Features

- Animated GIFs on the homepage, membership page, and dashboard
- Membership pricing shown in INR
- Personal trainer add-on option at `₹750/session`
- WhatsApp reminder and offers callout in the CRM dashboard

## Usage

Open `index.html` in a browser to view the site.
