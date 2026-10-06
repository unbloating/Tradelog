# CIPH Release Verification — Next Checklist

**Goal:** Close the remaining launch blockers with evidence, without weakening account privacy or claiming tests that were not run.

**Branch:** `ciph-public-release-checklist`  
**Current PR:** https://github.com/unbloating/Tradelog/pull/2  
**Status:** In progress — not launch-ready.

## 1. Supabase authentication hardening

- [ ] Enable leaked-password protection in Supabase Auth password/security settings.
- [ ] Re-run Supabase Security Advisor and record the resulting findings.
- [ ] Review the authenticated `create_direct_conversation` SECURITY DEFINER warning. Keep the RPC only if its caller/target validation, locked search path, and restricted grants are still correct; do not remove chat functionality just to silence a warning.
- [ ] Verify email confirmation, password reset, and sign-out behavior using real accounts; record any provider/email configuration blockers without recording secrets.

## 2. Account isolation and chat privacy

- [ ] Use two separate test accounts and confirm each can only read, create, update, and delete its own trades.
- [ ] Confirm signing out clears trade rows, dashboard values, profile state, and chat state before another account signs in.
- [ ] Confirm user A cannot join an existing conversation by direct membership insert or view messages in a conversation they do not belong to.
- [ ] Confirm direct chat creation works only through the validated RPC and only for allowed/public target profiles.
- [ ] Confirm private profile/strategy data remains private while intentionally public profiles and templates remain discoverable.
- [ ] Confirm manual social links and username search work without requiring social OAuth.

## 3. Journal and core feature regression

- [ ] Test creating, editing, and deleting a trade against the signed-in cloud account.
- [ ] Check trade totals, win rate, P&L, and potential win-rate/P&L calculator against known sample data.
- [ ] Check strategy/template save, view, and account scoping.
- [ ] Check existing legacy local data handling and ensure it is not displayed as another user's cloud data.
- [ ] Check news links and Forex Factory integration, including the visible news-alert behavior; document whether notifications require extra browser permission or a separate provider.

## 4. Browser, mobile, and release validation

- [ ] Run latest GitHub Actions static checks against the latest PR head and record the exact commit SHA and result.
- [ ] Inspect browser console/network errors during sign-in, trade CRUD, chat, and news loading.
- [ ] Test iPhone Safari layout, sign-in modal, keyboard behavior, home-screen icon/manifest, and dark/light themes.
- [ ] Verify the deployed URL serves the intended release commit and that no unreviewed changes are live.
- [ ] Recheck RLS and Storage policies after any schema or policy change.
- [ ] Update PR body and this checklist with evidence; only mark launch-ready after every required item is verified.

## User/admin-dependent blockers

These tasks cannot be honestly marked complete from repository code alone:
- Supabase dashboard-only Auth setting changes.
- Inbox-based email confirmation/reset tests.
- Two independent authenticated browser sessions/accounts.
- Real iPhone Safari and deployed-site smoke tests.

## Completion rule

When all sections are verified, archive this checklist as complete and create a new next-stage checklist (monitoring, backups/recovery, abuse controls, performance, and post-launch incident handling). If any item is blocked, document the exact blocker and continue with independent tasks. Never paste secrets or service-role keys into GitHub issues, code, or chat.
