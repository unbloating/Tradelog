# CIPH Public Launch Checklist

Use this checklist to verify CIPH before merging the release branch or announcing the app publicly. Check an item only after it has been tested and confirmed.

## 1. Account access and privacy

- [ ] Create a new account with a never-used email.
- [ ] Confirm email verification works from the actual email received.
- [ ] Sign in, sign out, then sign in again.
- [ ] Test forgot-password and complete a password reset from the email link.
- [ ] Confirm an unauthenticated visitor cannot view private journal entries.
- [ ] Create two separate test accounts and verify each account sees only its own trades, journal notes, P&L, and private data.
- [x] Inspect sign-out flow and verify the code clears in-memory state and avoids re-rendering stale dashboard rows; still perform live two-account testing before release.\n- [x] Add explicit signed-in `user_id` filters to both dashboard trade reads, clear in-memory dashboard rows when cloud trade loading fails, and stop writing cloud trade rows to shared browser storage after a successful save (live account tests still required).
- [x] Remove the policy that let signed-in users add themselves to any conversation; direct conversation creation is now routed through a validated authenticated RPC.
- [ ] Verify direct messages are visible only to conversation members using two real test accounts.
- [ ] Confirm public profiles reveal only the intended profile fields.
- [ ] Confirm profile social links are manual links only; no broken OAuth sign-in integrations are required.

## 2. Supabase security settings

- [x] Remove the policy that allowed any signed-in user to add themselves to any conversation.
- [x] Restrict the direct-conversation creation RPC to authenticated users and validate its target.
- [x] Remove duplicate permissive profile and strategy policies.
- [x] Remove additional redundant trade/social/like policies and block direct creation of empty conversations outside the validated RPC.
- [ ] In Supabase Auth settings, enable leaked-password protection.
- [x] Recheck Supabase Security Advisor; remaining warnings are documented below.
- [x] Verify all 13 public tables have Row Level Security enabled and inspect the public-schema policies.
- [x] Check avatar storage bucket is public-read, limited to image MIME types and 2 MB, with uploads scoped to the owner's folder.
- [ ] Verify production redirect URLs, site URL, email sender settings, and password-reset redirect URLs in the dashboard.

## 3. Journal and trading tools

- [ ] Create, edit, and delete a trade using a real account; reload and confirm it persists.
- [ ] Confirm trade history, win rate, P&L, and dashboard totals agree with the saved trades.
- [ ] Test the potential win-rate / P&L calculator with known example values.
- [ ] Confirm strategy templates load, save, and remain scoped to the correct account.
- [ ] Verify importing or migrating legacy local journal data does not overwrite cloud data.
- [x] Inspect the sign-out and empty-dashboard code paths for stale data handling.
- [ ] Check that the deployed app handles network errors and expired sessions without exposing private data.

## 4. CIPH news and market information

- [x] Inspect source links: Forex Factory calendar and breaking-news links are present.
- [x] Inspect notification copy: alerts are described as operating while CIPH is open and notifications are permitted, not as guaranteed price predictions.
- [ ] Verify event timestamps and timezone behavior with a known upcoming event.
- [ ] Test high-impact news notifications on a supported device and confirm permission-denied states are handled.
- [ ] Check Nasdaq bias/market analysis for clear timestamps and source attribution in the running app.
- [ ] Verify unavailable or delayed market/news data is clearly labeled instead of presented as live.
- [ ] Test the app when a news source is unavailable or slow.

## 5. Mobile and interface quality

- [ ] Test the deployed app on iPhone Safari.
- [ ] Test sign-in, account creation, password recovery, journal entry, chat, and news links on mobile.
- [ ] Check layout at narrow screen widths and with the keyboard open.
- [x] Inspect the source for CIPH logo, app icon/manifest, dark interface, and responsive breakpoints.
- [ ] Confirm there are no dead buttons, placeholder actions, or OAuth options that no longer work in a live browser session.
- [ ] Check accessibility basics: readable contrast, labels, focus states, and useful error messages.

## 6. Release and deployment

- [x] Record the latest RLS cleanup in a repository migration file on the release branch.\n- [x] Add a GitHub Actions workflow for inline JavaScript syntax checks, manifest JSON validation, and a basic frontend secret-pattern scan; first workflow run passed. Recheck after the latest commit.
- [ ] Run the available build, lint, and automated tests; record any missing test coverage.
- [ ] Confirm the release changes are merged into the deployment branch.
- [ ] Verify the hosting workflow completes successfully for the exact release commit.
- [ ] Open the public URL in a fresh/private browser session and confirm the expected version is deployed.
- [ ] Re-test sign-in and a saved journal entry on the deployed URL, not only in a development preview.
- [ ] Check browser console and network errors on the deployed site.
- [ ] Scan the full release artifact for private credentials and confirm no service-role secret is included in frontend files.
- [ ] Keep a rollback point and note the deployed commit before announcing the release.

## Latest verification results

- **Database:** Project reports healthy. All 13 public tables have RLS enabled.
- **Applied in production:** conversation-membership hardening, authenticated-only validated direct-chat RPC, duplicate permissive policy cleanup, and removal of redundant trade/social/like policies plus the direct conversation insert policy.
- **Repository:** corresponding policy cleanup migration added to the `ciph-public-release-checklist` branch.\n- **Latest code hardening:** both dashboard trade reads explicitly filter by the authenticated user ID; failed cloud trade loads clear visible in-memory rows; saving a cloud trade no longer copies the trade list into localStorage. Commits: `fbfed6862b77c9d953e93adbd9e3dd2dff1a2aff`, `de22e8342a5eda7bba6a1736c6baf2dc3a650912`.\n- **Static CI:** `.github/workflows/ciph-static-checks.yml` added in commit `c6ded4485e83c22724073b55a684fe4a3104493d`. GitHub Actions run `37490302360` passed inline JavaScript syntax checks, manifest JSON validation, and the frontend service-role-secret pattern scan. The later run for the trade-query change also passed all three steps; recheck the latest commit after this checklist update.
- **Remaining Supabase Security Advisor warnings:**
  1. **Leaked password protection is disabled.** This is an Auth dashboard setting and must be enabled by a project admin.
  2. **Authenticated SECURITY DEFINER function warning for `create_direct_conversation`.** The RPC is intentionally callable by authenticated users for chat creation; it validates the signed-in caller and target profile, uses a locked search path, and is not executable by anon. Review the warning rather than blindly disabling this required feature.
- **Not verified in this environment:** real sign-up/verification/reset emails, two-account end-to-end privacy tests, trade CRUD against a real session, iPhone Safari QA, browser console/network behavior, and successful production deployment of the release branch.
- **Release decision:** not launch-ready until the remaining dashboard setting and live-device/account tests are completed. Do not check items solely because code was inspected.
