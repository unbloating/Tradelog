# CIPH Account-Switch Privacy Checklist

**Status:** Source-level issue confirmed; implementation change is blocked in this run. Keep PR #3 in draft. This checklist does not claim the issue is fixed.

## Findings from release-branch source inspection — 2026-10-14

- [x] Confirmed the app loads a shared `tradelog:v1` local-storage state before authentication is resolved.
- [x] Confirmed startup restore copies cached `state.profile` username and bio into visible profile fields before `loadProfile()` confirms the current account.
- [x] Confirmed the `SIGNED_OUT` handler clears trade rows and dashboard totals but does not explicitly clear chat messages, active conversation ID, real-time chat channel, strategy rows, or manual profile-link inputs.
- [x] Confirmed `loadMessages()` reads the mutable `activeConversationId` and does not re-check account/conversation identity after its asynchronous query before rendering.
- [x] Confirmed chat and strategy database queries still rely on Supabase authorization/RLS; this finding is a client-side stale-state risk, not evidence that database RLS was bypassed.
- [x] Confirmed the latest static CI run [38154821511](https://github.com/unbloating/Tradelog/actions/runs/38154821511) completed successfully with all 8 substantive workflow steps passing on commit `ac5c360a8cb1186c7949674ac8e86a2af3e5c048`. This run predates any future privacy fix.

## Required implementation

- [ ] On both sign-out and account switch, blank account-specific profile fields and avatar, clear strategy rows, empty chat messages/list state, clear active conversation ID, and unsubscribe from the previous real-time channel.
- [ ] Prevent stale async profile, strategy, trade, chat-list, and message responses from rendering after account identity changes (use a generation/session guard).
- [ ] Remove pre-auth hydration of profile fields from shared local storage. Preserve existing local journal data in the existing legacy backup path before clearing shared state; do not delete cloud records or overwrite a different account's data.
- [ ] Keep the public community-template gallery and manual social-link fields functional for the currently signed-in owner.
- [ ] Add/extend automated checks for the account-switch guard markers and JavaScript syntax.
- [ ] Verify the exact new PR head's CI after the code change and update the release/launch checklists with the real result.

## Required hands-on verification

- [ ] Sign in as account A, open a private conversation, load strategies and profile links, then sign out; verify all account-specific UI is cleared immediately.
- [ ] Sign in as account B in the same browser; verify A's messages, conversation names, profile links, strategies, and journal rows never appear, including with slow network responses.
- [ ] Switch conversations quickly while messages load; verify a late response from the prior conversation cannot overwrite the active chat.
- [ ] Repeat with a hard refresh and with the browser back/forward cache.
- [ ] Confirm account A's cloud journal/messages remain intact after sign-out and are still visible to A on the next sign-in.

## Tooling blocker

On 2026-10-14, the connected GitHub write call for the proposed `index.html` account-state isolation patch was rejected by the write-safety layer. No source-code change or privacy-fix commit was created. The safe next step is to resolve the repository write permission/safety blocker and then implement and verify the patch; do not mark this checklist complete before that happens.

**Exit criteria:** implementation committed, CI green on the exact new PR head, and two-account same-browser tests completed. No production schema changes are required for this client-side fix.
