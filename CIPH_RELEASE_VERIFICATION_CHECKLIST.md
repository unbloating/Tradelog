# CIPH Release Verification — Active Gate

**Goal:** Close the remaining launch blockers with evidence, without weakening account privacy or claiming tests that were not run.  
**Branch:** ciph-public-release-checklist  
**Draft PR:** PR #3 remains open in draft state at https://github.com/unbloating/Tradelog/pull/3; PR #2 was merged on 2026-10-06.  
**Status:** In progress — not launch-ready.

## 1. Supabase authentication hardening

- [ ] Enable leaked-password protection in Supabase Auth password/security settings; this requires a project admin in the dashboard.
- [x] Re-run Supabase Security Advisor on 2026-10-09 and record both findings below.
- [x] Review the authenticated create_direct_conversation SECURITY DEFINER warning. The function validates auth.uid(), rejects null/self targets, permits only public target profiles, uses an empty locked search_path, and checks membership before creating a conversation. EXECUTE is granted to authenticated, postgres, and service_role; anon has no grant. Keep the warning documented rather than weakening chat security.
- [ ] Verify email confirmation, password reset, sign-out, and repeat sign-in using real accounts.
- [ ] Verify production site URL, redirect allow-list, password-reset redirect URLs, email sender settings, and hosted Google/Discord provider toggles in the Supabase dashboard.
- [x] Disable Google/Discord OAuth in repository-local `supabase/config.toml` to match manual social-profile links; this does not change hosted Supabase settings.

## 2. Account isolation and chat privacy

- [x] Inspect public-schema policies: all 13 public tables have RLS enabled.
- [x] Inspect the trade and message policies: trade rows are scoped to auth.uid(); message reads/sends require conversation membership; private profiles/strategies are limited to their owner while public profiles/strategies remain discoverable.
- [x] Inspect direct-chat creation: the validated RPC is the intended path; the prior direct conversation insert policy is absent.
- [ ] Use two independent test accounts to verify each can read/create/update/delete only its own trades, notes, P&L, and private data.
- [ ] Confirm sign-out clears dashboard rows, totals, profile state, and chat state before another account signs in.
- [ ] Confirm user A cannot add themselves to an existing conversation or read messages for a conversation they do not belong to.
- [ ] Test public profile/template discovery and manual social links in a live browser; no OAuth provider login should be required.

## 3. Journal and core feature regression

- [ ] Create, edit, delete, and reload a trade with a real signed-in account.
- [ ] Compare saved trade history, win rate, P&L, and dashboard totals against known sample values.
- [ ] Test the potential win-rate/P&L calculator with known example values.
- [ ] Save/view strategy templates and verify private templates remain account-scoped while public templates are discoverable.
- [ ] Verify legacy local journal data cannot overwrite cloud data or appear as another user's data.

## 4. CIPH news and market information

- [x] Keep the in-app headline feed and cautious rule-based directional outlook in the integrated News & Bias view. It is not a verified live NQ price model or a guaranteed trading signal.
- [x] Preserve official Forex Factory calendar and news links as source references alongside the existing economic-calendar link; CIPH does not scrape or republish Forex Factory content.
- [ ] Verify the RSS feed freshness, attribution, and visible error/fallback state in a running browser.
- [ ] Open the calendar/news source links and verify source event times before trading.
- [ ] Test browser-notification permission granted/denied states and confirm alerts are described as page-open only, not background push.

## 5. Browser, mobile, and release validation

- [x] Reconcile the release branch with the current main app tree at `7db9f9a8ddda29a05b778823de62695d26da476c`, preserving the latest email-OTP verification flow and actual logged-trade journal history while retaining CIPH branding and official Forex Factory source links.
- [x] Expand static checks to syntax-check inline JavaScript in every root HTML page, validate the web manifest, scan tracked files for recognizable Supabase server-side key patterns, guard core CIPH feature markers, and assert email OTP/journal-history markers plus disabled local social OAuth.
- [ ] Verify GitHub Actions succeeds on the exact final PR head; record the latest run in the PR description after the final checklist-only update.
- [ ] Test desktop and iPhone Safari layout, sign-in modal, keyboard behavior, home-screen icon/manifest, and dark/light themes.
- [ ] Inspect browser console/network errors during sign-in, trade CRUD, chat, and news loading.
- [ ] Verify the public URL serves the intended merged commit; do not claim deployment before checking it.
- [ ] Review the draft PR and merge only after the remaining required tests are complete.

## Latest verification evidence — 2026-10-10

- Current main head inspected: `7db9f9a8ddda29a05b778823de62695d26da476c` (“Show real logged trades in the journal history”). The release branch was behind main in commit history; the release candidate now uses the current main app tree while retaining its CIPH branding, official Forex Factory source links, release checks, and checklists.
- The updated app source includes email one-time-code verification and the actual `journalTradeHistory` view that renders saved trades. This is source inspection, not a substitute for real inbox/account testing.
- Main Pages workflow run [38009376736](https://github.com/unbloating/Tradelog/actions/runs/38009376736) completed successfully for main commit `7db9f9a8ddda29a05b778823de62695d26da476c`; it does not deploy the unmerged draft PR.
- Supabase project status: ACTIVE_HEALTHY.
- Database query: 13 of 13 public tables have RLS enabled.
- Avatar storage bucket: public-read, limited to 2 MB, accepts image MIME types only; authenticated upload/update policies scope paths to the caller's own folder.
- Security Advisor findings observed on 2026-10-10: leaked-password protection is disabled; the authenticated SECURITY DEFINER warning for `create_direct_conversation` remains. Its caller/target validation, locked empty `search_path`, membership checks, and lack of anon EXECUTE were reviewed; do not weaken chat security to silence the warning.
- **Migration-history drift confirmed:** live Supabase history lists 11 applied versions (from `20260927165415` through `20261006153319`), while the repository contains only two migration files. The repository cleanup migration is named `20261006153300_remove_redundant_policies_and_lock_conversation_creation.sql`, but the live applied version is `20261006153319`. No migration was applied. Do not run `db push` until the missing history is recovered or a non-destructive baseline is reviewed.
- Repository-local `supabase/config.toml` now disables Google and Discord OAuth to match manual social links. This does not verify or change hosted Auth provider toggles.
- The in-app headline tone/outlook is heuristic and can be delayed; it must not be presented as a verified live-price signal.

## Not verified here — blockers

- Supabase dashboard-only leaked-password protection, production Auth/email settings, and hosted social-provider toggles.
- Actual inbox-based confirmation/OTP and password-reset tests.
- Two independent signed-in sessions and end-to-end account/chat privacy tests.
- Live trade create/edit/delete, dashboard totals, calculator, template visibility, and legacy-data tests.
- iPhone Safari QA, browser console/network inspection, news-feed fallback/attribution tests, notification permission states, and deployed-URL verification.
- Migration-history reconciliation before any future migration deployment.

**Release decision:** not launch-ready. Never paste secrets or service-role keys into code, issues, or chat.
