# TradeLog security baseline

- Never commit OAuth client secrets, Supabase service-role keys, database passwords, or API keys.
- Public profiles expose only fields intentionally marked public.
- Trade notes are private by default.
- Database access is protected with Supabase Row Level Security.
- Social OAuth tokens must remain server-side; the browser must never receive provider refresh tokens.
- Rate-limit account creation, login, profile edits, trade writes, and social-link endpoints before public launch.
- Add email verification, password reset, abuse reporting, account deletion, and privacy-policy/terms pages before inviting broad public use.
- Treat all imported social/profile data as untrusted input and escape it when rendering.
