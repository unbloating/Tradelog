# CIPH Public Launch Checklist

Use this checklist to verify CIPH before merging the release branch or announcing the app publicly. Check an item only after it has been tested and confirmed.

## 1. Account access and privacy

- [ ] Create a new account with a never-used email.
- [ ] Confirm email verification works from the actual email received.
- [ ] Sign in, sign out, then sign in again.
- [ ] Test forgot-password and complete a password reset from the email link.
- [ ] Confirm an unauthenticated visitor cannot view private journal entries.
- [ ] Create two separate test accounts and verify each account sees only its own trades, journal notes, P&L, and private data.
- [ ] Sign out of Account A and confirm none of Account A's data remains visible before or after Account B signs in.
- [ ] Confirm public profiles reveal only the intended profile fields.
- [ ] Confirm users cannot join another person's private chat by guessing or reusing a conversation ID.
- [ ] Verify direct messages are visible only to conversation members.
- [ ] Confirm profile social links are manual links only; no broken OAuth sign-in integrations are required.

## 2. Supabase security settings

- [x] Remove the policy that allowed any signed-in user to add themselves to any conversation.
- [x] Restrict the direct-conversation creation RPC to authenticated users and validate its target.
- [x] Remove duplicate permissive profile and strategy policies.
- [ ] In Supabase Auth settings, enable leaked-password protection.
- [ ] Recheck Supabase Security Advisor and review every remaining warning.
- [ ] Recheck RLS policies for every table containing user, journal, chat, or profile data.
- [ ] Confirm storage uploads are restricted to the owner's permitted folder and file types.
- [ ] Verify all production redirect URLs, site URL, email sender settings, and password-reset redirect URLs.

## 3. Journal and trading tools

- [ ] Create, edit, and delete a trade; reload and confirm it persists.
- [ ] Confirm trade history, win rate, P&L, and dashboard totals agree with the saved trades.
- [ ] Test the potential win-rate / P&L calculator with known example values.
- [ ] Confirm strategy templates load, save, and remain scoped to the correct account.
- [ ] Verify importing or migrating legacy local journal data does not overwrite cloud data.
- [ ] Confirm empty states and first-time-user screens work without showing stale data.
- [ ] Check that the app handles network errors and expired sessions without exposing private data.

## 4. CIPH news and market information

- [ ] Confirm Forex Factory opens the intended calendar page.
- [ ] Verify the displayed news/event times use the intended timezone.
- [ ] Test high-impact news notifications on a supported device and confirm permission-denied states are handled.
- [ ] Confirm notifications are not described as guaranteed price predictions.
- [ ] Check Nasdaq bias/market analysis for clear timestamps and source attribution.
- [ ] Verify unavailable or delayed market/news data is clearly labeled instead of presented as live.
- [ ] Test the app when a news source is unavailable or slow.

## 5. Mobile and interface quality

- [ ] Test the current deployed app on iPhone Safari.
- [ ] Test sign-in, account creation, password recovery, journal entry, chat, and news links on mobile.
- [ ] Check layout at narrow screen widths and with the keyboard open.
- [ ] Verify logo, app icon, dark/light theme, buttons, and modal behavior.
- [ ] Confirm there are no dead buttons, placeholder actions, or OAuth options that no longer work.
- [ ] Check accessibility basics: readable contrast, labels, focus states, and useful error messages.

## 6. Release and deployment

- [ ] Review the release branch diff and resolve any merge conflicts.
- [ ] Run the available build, lint, and automated tests; record any missing test coverage.
- [ ] Confirm the release changes are merged into the deployment branch.
- [ ] Verify the hosting workflow completes successfully for the exact release commit.
- [ ] Open the public URL in a fresh/private browser session and confirm the expected version is deployed.
- [ ] Re-test sign-in and a saved journal entry on the deployed URL, not only in a development preview.
- [ ] Check browser console and network errors on the deployed site.
- [ ] Confirm no service-role secrets or other private credentials are included in frontend files.
- [ ] Keep a rollback point and note the deployed commit before announcing the release.

## Current known status

- **Completed in code/database:** direct-chat membership policy hardening, authenticated-only direct-conversation RPC, duplicate permissive policy cleanup, sign-out cached-data cleanup, and stale dashboard row handling.
- **Known outstanding configuration item:** Supabase leaked-password protection is disabled and must be enabled in the Supabase dashboard.
- **Not yet verified:** full two-account privacy testing, real email/auth flows, mobile QA, automated release checks, and the latest deployed version.
- **Release rule:** do not mark the app launch-ready until all applicable unchecked items are tested and any remaining security warnings are understood.
