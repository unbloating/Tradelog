# CIPH Daily Market Brief — Implementation Checklist

**Goal:** Build a mobile-friendly, free daily market-news brief with in-app headlines and a cautious trading-readiness summary, without requiring a paid Supabase upgrade or risking existing TradeLog data.

**Repository:** `unbloating/Tradelog`
**Working branch:** `ciph-public-release-checklist`
**Status:** Daily headline UI implemented on `main` in commit `0088fda36b701264f25c3b2650777a6aa0e872ca`. It queries recent public news via GDELT’s document API and produces a transparent, rule-based headline-risk summary. Deployment and live API behavior still need verification.

## Product scope

- [x] Keep CIPH focused on market news; do not require sign-in just to read public news. Standalone `news.html` does not call Supabase or require an account.
- [x] Remove Forex Factory links from the main user experience per user request. The page displays recent business and macro headlines in-app.
- [x] Use a public news endpoint rather than copying or republishing Forex Factory content. Current headline source: GDELT DOC API; titles link to the publisher domain when available.
- [x] Display headlines inside CIPH instead of sending users to Forex Factory.
- [x] Add an in-app Nasdaq-focused daily headline-risk assessment with Caution / Mixed / No major headline-risk cluster labels. It explicitly avoids promising direction or profit.
- [x] Show the device's local clock/timezone and label headline recency. Do not invent event rows, event times, countdowns, or alert delivery.
- [x] Keep the UI clean, dark-mode friendly, responsive, and usable on iPhone Safari. Added a responsive dark interface, keyboard-accessible source links, mobile layout, reduced-motion support, and device-local clock.

## Free-first technical approach

- [x] Avoid requiring a Supabase paid plan for public news browsing. The new public page is static and does not initialize Supabase.
- [x] Keep the existing TradeLog data, database, and app available; do not delete or migrate user data as part of this scope reduction. The implementation adds `news.html` and leaves existing journal/database code untouched.
- [x] Separate public news/calendar browsing from optional account-backed journal features. The new page is independent of authentication and account state.
- [x] Avoid introducing API keys or server secrets into frontend code. No keys, API calls, proxy, or third-party data ingestion added.
- [x] Document limitations: the headline-risk assessment is a lightweight keyword heuristic, not a complete economic calendar, real-time price analysis, or personalized financial advice. API availability/CORS must be verified in deployment.
- [x] Treat browser notifications as optional and permission-dependent; do not claim dependable background push unless implemented and tested. This news page makes no notification or background-push claims.

## Verification and release

- [x] User confirmed the official Forex Factory links work on their device. Desktop-specific QA remains unverified.
- [ ] Verify the daily brief UI remains useful when the live news API is unavailable; confirm it clearly avoids stale/guessed headlines.
- [x] Static checks passed on merged commit `e8e9ed8448d5814ab4049bee919c927bd8a9a90f`; [GitHub Actions run #29](https://github.com/unbloating/Tradelog/actions/runs/37499227715) succeeded.
- [x] Confirm changes do not delete or overwrite existing TradeLog data/features by limiting this implementation to a new standalone static page and this checklist.
- [x] Updated the main release checklist and PR description to reflect the reduced scope.
- [ ] Verify the published news URL returns HTTP 200 and opens in a fresh/private browser. The merge is complete, but deployment is not yet verified.

## Next checklist rule

Once the live URL and mobile behavior are verified, create the next checklist for source reliability, event-time correctness, accessibility, and lightweight ongoing maintenance. Keep any account-backed TradeLog launch blockers separate from public news browsing.
