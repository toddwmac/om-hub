# om-xample

Two self-contained, data-driven report pages hosted on GitHub Pages.

## Live site

**https://toddwmac.github.io/om-xample/**

## Reports

- [Fable — Startup Decade Report (2015–2025)](Fable-startup-report.html)
- [Grok — Startup Ecosystem Report (2016–2026)](Grok-startup-report.html)
- [index.html](index.html) — landing page that links to everything

## AI Arena showcases (external)

Model-generated pages hosted on Arena. They are **not** part of this repo — the
landing page links out to them, opening in a new tab.

- [OpenAI Prompting Strategy Shift](https://019f8a0f-9862-7864-9943-ca8ccdfdfcf8.arena.site/) — created by Qwen36-27b
- [OpenAI Prompting Guide 2025](https://019f8a0f-9862-7d23-b5d8-6c9aa3ee42f6.arena.site/) — created by DeepSeek-v4

## Publishing changes

GitHub Pages automatically rebuilds whenever you push to the `main` branch, so
publishing a change is just a commit and a push. The helper script does both:

```powershell
.\deploy.ps1                 # commit + push with an auto (timestamp) message
.\deploy.ps1 -m "Add Q3 chart"   # commit + push with your own message
```

Run it from this folder. The live site updates at the URL above within about a
minute. You can also use plain git if you prefer:

```powershell
git add -A
git commit -m "describe the change"
git push
```

## Tech

Plain static HTML, CSS, and Chart.js. No build step — pages are served exactly
as they sit in this repository.
