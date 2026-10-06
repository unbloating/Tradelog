# CIPH Free Forex Factory News App — Implementation Checklist

**Goal:** Simplify CIPH into a mobile-friendly, free-to-use market news and economic-calendar app centered on Forex Factory, without requiring a paid Supabase upgrade or risking existing TradeLog data.

**Repository:** `unbloating/Tradelog`
**Working branch:** `ciph-public-release-checklist`
**Status:** Product-scope implementation complete on the working branch. Official-source links are used because Forex Factory's published terms prohibit unauthorized copying/republication; no permission for an embed/feed/API was established. Verification and release tasks remain below.

## Product scope

- [x] Keep CIPH focused on market news and the economic calendar; do not require sign-in just to read public news. Added standalone `news.html` public entry point; it does not call Supabase or require an account.
- [x] Make Forex Factory the primary source via official pages: https://www.forexfactory.com/calendar and https://www.forexfactory.com/news.
- [x] Check Forex Factory's current terms and available official embedding/feed/API options. Its [published terms](https://www.forexfactory.com/notices) prohibit unauthorized copying, republication, and redistribution. No authorized embedding/feed/API option was established during this pass, so CIPH does not scrape or republish source content.
- [x] If permitted direct integration is unavailable, use clearly labeled links that open Forex Factory's official calendar/news pages rather than an unreliable or unauthorized data feed.
- [x] Add a Nasdaq-focused briefing that explains possible market relevance without promising directional predictions. The briefing covers U.S. releases, rates, large-cap tech earnings, and execution risk; it is educational, not a live signal.
- [x] Show event times with a clear timezone label and avoid inventing countdowns, impact labels, or alert delivery. The page displays the device's local clock/timezone and instructs users to verify actual event times/impact on Forex Factory; it does not fabricate event rows or countdowns.
- [x] Keep the UI clean, dark-mode friendly, responsive, and usable on iPhone Safari. Added a responsive dark interface, keyboard-accessible source links, mobile layout, reduced-motion support, and device-local clock.

## Free-first technical approach

- [x] Avoid requiring a Supabase paid plan for public news browsing. The new public page is static and does not initialize Supabase.
- [x] Keep the existing TradeLog data, database, and app available; do not delete or migrate user data as part of this scope reduction. The implementation adds `news.html` and leaves existing journal/database code untouched.
- [x] Separate public news/calendar browsing from optional account-backed journal features. The new page is independent of authentication and account state.
- [x] Avoid introducing API keys or server secrets into frontend code. No keys, API calls, proxy, or third-party data ingestion added.
- [x] Document any limitations caused by third-party terms, cross-origin restrictions, or source availability. The page and this checklist explain why official outbound links are used; no external content is embedded.
- [x] Treat browser notifications as optional and permission-dependent; do not claim dependable background push unless implemented and tested. This news page makes no notification or background-push claims.

## Verification and release

- [ ] Test the official Forex Factory links on desktop and iPhone.
- [ ] Verify the news/calendar UI remains useful if external content cannot be embedded or is unavailable. The static fallback is implemented; perform manual device checks.
- [ ] Run static checks and record the exact commit and workflow result.
- [x] Confirm changes do not delete or overwrite existing TradeLog data/features by limiting this implementation to a new standalone static page and this checklist.
- [ ] Update the main release checklist and PR description to reflect the reduced scope.
- [ ] Do not merge or claim production deployment until the intended changes are reviewed and the deployed URL is verified.

## Next checklist rule

Once the free Forex Factory-centered news experience is implemented and verified, create the next checklist for source reliability, event-time correctness, accessibility, and lightweight ongoing maintenance. Keep any account-backed TradeLog launch blockers separate from public news browsing.
