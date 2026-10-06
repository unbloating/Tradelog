# CIPH Intelligence

CIPH is a dark, minimal market-intelligence web app focused on Nasdaq futures context, market-moving headlines, economic events, liquidity levels, and trade journaling.

## Current features
- Market-bias workspace for NQ/MNQ with manually confirmed structure, liquidity and rates context
- Recent macro/Nasdaq headlines with keyword-only tone labels
- Browser notifications for major-news keywords while the page is open (not background push)
- Forex Factory calendar and breaking-news links
- Trade journal, P&L tracking, strategy templates, potential-results calculator, profile links and chat UI
- Responsive desktop and mobile layout with dark/light appearance controls

## Publish with GitHub Pages
1. Open Settings → Pages in this repository.
2. Choose Deploy from a branch.
3. Select `main` and `/(root)`, then save.
4. The project site is available at https://unbloating.github.io/Tradelog/ after deployment finishes.

## Data and accuracy notes
- The market-bias score depends on user-selected conditions; it is not a predictive model or a verified live market feed.
- Headlines currently use a third-party RSS converter; keyword tone is not a reliable impact assessment.
- Browser alerts only poll while the app is open and notification permission is granted. Reliable background push requires a push service/backend.
- Forex Factory is linked for the calendar and breaking news; this version does not ingest an official Forex Factory data feed.
- GitHub Pages is static hosting. Secure multi-user accounts, private cloud journals, and production chat require correctly configured backend/database policies. Do not put secret keys in frontend code.

## Disclaimer
CIPH is an informational and journaling tool, not financial advice. News, levels, and scenario calculations can be inaccurate or delayed. Verify sources and define risk before trading.
