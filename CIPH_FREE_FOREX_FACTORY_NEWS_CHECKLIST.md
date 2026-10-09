# CIPH Daily Market Brief — Current Scope & Verification

**Repository:** unbloating/Tradelog  
**Working branch:** ciph-public-release-checklist  
**Status:** Integrated News & Bias view is implemented; live browser and deployment checks remain open.

## Current scope
- [x] Public headline browsing does not require sign-in.
- [x] Recent macro/Nasdaq headlines are shown in the app through the existing RSS-converter path.
- [x] The directional read is a cautious heuristic based on headline keywords and manually selected market conditions, not a verified live-price model.
- [x] Official Forex Factory calendar and news links are provided as optional source references. CIPH does not scrape or republish their content.
- [x] Preserve the TradeLog journal, potential win-rate/P&L calculator, public username/template discovery, manual social links, and private account-backed features.
- [x] Browser alerts are optional and permission-dependent; no background-push guarantee is made.

## Still to verify
- [ ] Confirm headline freshness, source attribution, and useful error/fallback behavior when the RSS converter is unavailable.
- [ ] Open the Forex Factory calendar/news links on desktop and iPhone Safari.
- [ ] Verify event times on the source calendar; CIPH does not ingest an official Forex Factory event feed.
- [ ] Test notification permission-granted and permission-denied states.
- [ ] Verify the deployed public URL in a fresh/private browser session and confirm News & Bias loads without sign-in.

## Scope notes
- The public entry point news.html redirects to index.html?view=bias; the feed and outlook live in the unified index.html app.
- Headlines currently use a third-party RSS converter. Keyword tone is a lightweight heuristic, not AI-verified impact or a complete economic calendar.
- Forex Factory remains an optional source link, not an ingested data feed.
- No paid Supabase plan, new API key, service-role secret, or data migration was added for this news scope.
- This checklist is not complete until the live API, mobile, and deployed-URL checks are verified.
