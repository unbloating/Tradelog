# CIPH public release checklist

This checklist is the release gate for combining the existing TradeLog journal with CIPH market intelligence. Do not describe the app as production-ready until the unchecked security and live-service checks below have been completed.

## Changes made in this branch
- [x] Preserve the existing `tradelog:v1` browser storage key so this update does not intentionally wipe existing local journal data.
- [x] Restrict the Strategy Templates management list to the signed-in user's own strategies; public community sharing remains a separate feature.
- [x] Require an active session before fetching dashboard P&L trades, and handle refresh errors without silently treating them as valid results.
- [x] Clear stale trade rows on sign-out, stop copying cloud trades into shared browser storage, and back up legacy local-only entries under `tradelog:legacy:v1` on sign-out.
- [x] Remove direct self-join permission for chat rooms; direct-chat memberships are now created only through the authenticated RPC.
- [x] Restrict the direct-chat RPC to authenticated users and harden its search path; it only starts chats with public profiles.
- [x] Keep CIPH's market-news/bias interface, Forex Factory links, browser news alerts, journal, and potential P&L calculator in the existing app rather than replacing it with a blank starter.

## Required before public release
- [ ] In Supabase, inspect the actual production schema and confirm Row Level Security is enabled for every private table: `trades`, `strategies`, `conversations`, `conversation_members`, `messages`, and any account-specific tables.
- [x] Inspect policies: trade rows require `user_id = auth.uid()` for read/write; strategy writes are owner-scoped and public/private reads are policy-gated; messages require conversation membership and sender ID must match `auth.uid()`.
- [x] Remove the policy that let any authenticated user add themselves to any conversation; only the authenticated direct-chat RPC can create participant rows.
- [ ] Run an actual two-account adversarial test of trade isolation, chat membership, and unauthorized writes before public launch.
- [ ] Verify profile fields intended for public discovery are public, but email addresses, private journal data, and account metadata are not exposed through profile queries.
- [x] Inspect template visibility and owner policies plus avatar storage policies. The avatar bucket is public-read, restricted to 2 MB and PNG/JPEG/WEBP/GIF, and upload/update policies restrict paths to the user's own folder.
- [ ] Verify template likes/saves and avatar storage behavior end-to-end using separate accounts.
- [ ] Test two separate accounts: create trades and private strategies in Account A, then sign into Account B and confirm none of A's private data appears or can be queried/changed. Test chat membership and template privacy too.
- [ ] Test sign-up, email verification, sign-in, sign-out, password reset, recovery deep link, and expired/invalid session flows on desktop and mobile.
- [ ] Confirm the Supabase Auth Site URL and redirect allow-list include the actual deployed CIPH URL and the recovery flow returns to the app.
- [ ] Enable Supabase leaked-password protection in Auth settings (the security advisor currently reports it disabled).
- [ ] Test market headlines, Forex Factory event links, browser notification permission, repeated-alert deduplication, and behavior when the news feed/proxy is unavailable. Browser notifications only work while the site is open unless a separate push service/service worker is configured.
- [ ] Run a JavaScript syntax check and mobile layout smoke test; verify theme controls, journal entry, P&L calculations, potential calculator, template publishing, manual social links, and chat.
- [ ] Confirm the GitHub Pages deployment workflow completed successfully after changes are merged, then test the published URL in a clean browser session.
- [ ] Review Supabase logs and any deployment/build failures before inviting public users.

## Important limits
The frontend uses a Supabase publishable/anon key, which is expected for a browser app; security must come from correct server-side RLS and storage policies, never from hiding the key. This repository review cannot prove production database policies, Auth dashboard settings, or live email/news delivery without checking the connected Supabase project and deployed service. Do not put a Supabase service-role key in this repository.
