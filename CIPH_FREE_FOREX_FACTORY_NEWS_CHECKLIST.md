# CIPH Free Forex Factory News App — Implementation Checklist

**Goal:** Simplify CIPH into a mobile-friendly, free-to-use market news and economic-calendar app centered on Forex Factory, without requiring a paid Supabase upgrade or risking existing TradeLog data.

**Repository:** `unbloating/Tradelog`
**Working branch:** `ciph-public-release-checklist`
**Status:** Planning/implementation checklist — Forex Factory integration method and permissions must be verified before coding any scraping or embedding.

## Product scope

- [ ] Keep CIPH focused on market news and the economic calendar; do not require sign-in just to read public news.
- [ ] Make Forex Factory the primary source via official pages: https://www.forexfactory.com/calendar and https://www.forexfactory.com/news.
- [ ] Check Forex Factory's current terms and available official embedding/feed/API options. Do not assume a public API exists, scrape pages, or republish their content without permission.
- [ ] If permitted direct integration is unavailable, use clearly labeled links that open Forex Factory's official calendar/news pages rather than an unreliable or unauthorized data feed.
- [ ] Add a Nasdaq-focused briefing that explains possible market relevance without promising directional predictions.
- [ ] Show event times with a clear timezone label and avoid inventing countdowns, impact labels, or alert delivery.
- [ ] Keep the UI clean, dark-mode friendly, responsive, and usable on iPhone Safari.

## Free-first technical approach

- [ ] Avoid requiring a Supabase paid plan for public news browsing.
- [ ] Keep the existing TradeLog data, database, and app available; do not delete or migrate user data as part of this scope reduction.
- [ ] Separate public news/calendar browsing from optional account-backed journal features.
- [ ] Avoid introducing API keys or server secrets into frontend code.
- [ ] Document any limitations caused by third-party terms, cross-origin restrictions, or source availability.
- [ ] Treat browser notifications as optional and permission-dependent; do not claim dependable background push unless implemented and tested.

## Verification and release

- [ ] Test the official Forex Factory links on desktop and iPhone.
- [ ] Verify the news/calendar UI remains useful if external content cannot be embedded or is unavailable.
- [ ] Run static checks and record the exact commit and workflow result.
- [ ] Confirm changes do not delete or overwrite existing TradeLog data/features.
- [ ] Update the main release checklist and PR description to reflect the reduced scope.
- [ ] Do not merge or claim production deployment until the intended changes are reviewed and the deployed URL is verified.

## Next checklist rule

Once the free Forex Factory-centered news experience is implemented and verified, create the next checklist for source reliability, event-time correctness, accessibility, and lightweight ongoing maintenance. Keep any account-backed TradeLog launch blockers separate from public news browsing.
