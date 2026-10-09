# CIPH Public Launch Checklist

Do not announce CIPH as launch-ready until the open tests below are complete.

## Account access and privacy
- [ ] Test signup, email confirmation, sign-in, sign-out, and password reset with real accounts.
- [ ] Use two independent accounts to verify trade/journal data and private messages stay account-scoped.
- [x] Code inspection confirms trade reads filter by the signed-in user ID and clear visible rows on failed/empty loads.
- [x] Database review confirms all 13 public tables have RLS enabled; live two-account testing is still required.
- [ ] Test public profile and template discovery, manual social links, and chat membership with real sessions.

## Supabase
- [x] Review trade, message, profile, strategy, conversation, and storage policies.
- [x] Verify the avatar bucket is public-read, limited to 2 MB and image MIME types, with owner-folder upload/update policies.
- [ ] Enable leaked-password protection in Supabase Auth settings.
- [ ] Verify site/redirect URLs, password-reset redirects, and email sender settings in the dashboard.

## Journal and trading tools
- [ ] Test trade create/edit/delete and persistence after reload.
- [ ] Compare dashboard P&L, win rate, and totals against known sample data.
- [ ] Test the potential win-rate/P&L calculator with known examples.
- [ ] Test strategy/template saving, visibility, and account scoping.
- [ ] Verify legacy local data cannot overwrite cloud data or appear as another account's data.

## CIPH News & Bias
- [x] Keep the integrated headline feed and cautious rule-based directional outlook in index.html; news.html redirects to index.html?view=bias.
- [x] Include official Forex Factory calendar/news links alongside the existing economic-calendar link; CIPH does not scrape or republish Forex Factory content.
- [x] Keep notification wording limited to page-open alerts when browser permission is granted.
- [ ] Test feed freshness, source attribution, error/fallback behavior, and external links on desktop and iPhone Safari.
- [ ] Verify event times on the source calendar and test notification permission granted/denied states.

## Mobile and deployment
- [x] Extend static CI to check inline JavaScript across root HTML files, manifest JSON, core feature markers, and recognizable server-side key patterns.
- [ ] Verify static CI succeeds on the exact final PR head.
- [ ] Test iPhone Safari, narrow widths, keyboard behavior, accessibility basics, and browser console/network errors.
- [ ] Verify the public URL and hosting workflow serve the intended merged commit.
- [ ] Record a rollback point and deployed commit before announcing the release.

## Evidence — 2026-10-09
- Supabase project status: ACTIVE_HEALTHY.
- RLS: 13 of 13 public tables enabled.
- Avatar storage: public-read, 2 MB limit, image MIME types only; uploads/updates scoped to the caller's folder.
- Security Advisor has two warnings: leaked-password protection is disabled (dashboard action required), and the authenticated direct-chat SECURITY DEFINER function is callable by authenticated users. The function was reviewed: it validates caller/target, uses an empty locked search_path, and has no anon EXECUTE grant.
- Real email tests, two-account privacy tests, live journal/calculator tests, iPhone Safari QA, and deployed-site verification remain outstanding.

**Release decision: not launch-ready.**
