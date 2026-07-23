# om-xample

**OM Hub** — a small static site on GitHub Pages. It hosts two data-driven
startup report pages and links out to a curated set of external AI showcases,
research, and analytics resources. Every link opens in a new tab.

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

## Research & Analytics resources (external)

External reading and reference sites linked from the landing page. They are
**not** part of this repo — the landing page links out to them, opening in a
new tab.

- [Artificial Analysis](https://artificialanalysis.ai/) — independent benchmarks and leaderboards for AI models and API providers
- [Emergent Mind](https://www.emergentmind.com/) — discover and learn new arXiv research fast
- [Kingy AI](https://kingy.ai/) — AI product discovery, tool directory, and YouTube coverage
- [Hugging Face — Trending Prompting Papers](https://huggingface.co/papers/trending?q=Prompting+) — daily trending arXiv papers on prompting
- [AINews by smol.ai](https://news.smol.ai/) — weekday AI news recaps for engineers
- [Forward Future](https://forwardfuture.com/) — Matthew Berman's daily AI newsletter

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
