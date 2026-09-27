# TradeLog public-launch checklist

TradeLog is being prepared as a multi-user trading journal.

## Architecture

- Frontend: the existing web UI.
- Auth + PostgreSQL: Supabase.
- Database: profiles, trades, strategies, and social connections.
- OAuth: provider authorization handled by Supabase/backend; secrets stay server-side.
- Hosting: a frontend host that can supply the Supabase URL/key at deploy time. GitHub Pages can continue serving a static demo, but it cannot securely run the backend itself.

## Required before public launch

1. Create/connect a Supabase project.
2. Apply `supabase/migrations/001_tradelog.sql`.
3. Configure authentication and email verification.
4. Configure OAuth providers and exact production redirect URLs.
5. Add the production Supabase URL and publishable/anon key to the frontend host's environment variables.
6. Connect the journal UI to Supabase instead of local-only storage.
7. Add password reset, account deletion, privacy controls, report/block flows, and rate limiting.
8. Publish Terms of Service and Privacy Policy.
9. Test RLS with two separate accounts to verify private trades cannot cross accounts.
10. Test OAuth callback/error/revocation flows.
11. Run a production smoke test on mobile and desktop.
12. Only then switch the public launch URL to the production host.

## Social integrations

Discord, Instagram, and X should be implemented through provider-approved OAuth flows. Exact permissions and app-review requirements vary by provider and can change, so provider dashboards must be configured using their current documentation. Do not place client secrets in frontend JavaScript.

## Important

The hypothetical P&L calculator is scenario modeling only. It is not a promise, forecast, or guarantee of trading performance.
