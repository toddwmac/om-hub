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

## Staying current: date & visibility features

The landing page helps visitors **spot new content**, **track what they've read
and liked**, and **export their reading list** — all client-side (browser
`localStorage`, no account or backend). Nothing appears until the visitor uses
it, so the default view stays calm.

### Dates & "what's new"

- Every card carries a `data-added="YYYY-MM-DD"` date.
- A per-card **"Added Jul 25, 2026"** line shows when it was published.
- A header banner reads **"Latest addition: [title] — date"** and links straight
  to that content.
- A **"New to you"** pill appears on cards added *since the visitor's last
  visit* (tracked via `localStorage` key `omhub.lastSeen`). The first visit shows
  no pills and seeds the baseline automatically; marking a card visited clears
  its pill in real time.

### Tracking engagement (per visitor, on this device)

- **Visited (✓)** — auto-marked the moment a card's link is opened, or toggled
  manually. Stored in `omhub.visited`.
- **Like (♡)** — mark favorites; liked cards get a faint rose edge so they pop
  without filtering. Stored in `omhub.liked`.
- **Notes (✎)** — jot a per-card note. Stored in `omhub.notes`.

### Filtering & sharing views

Three toolbar chips combine with AND logic:

- **♡ Liked only** — your favorites
- **✓ Hide read** — hides visited cards (your to-read queue)
- **✦ New only** — items carrying a "New to you" pill

Active filters are written to the URL (e.g. `?view=liked,unread`), so any view
is **shareable and bookmarkable** and restores on reload. While filtering, a
status line shows live counts ("3 liked · 5 visited · 1 new"), section headers
show **"visible / total"** (e.g. "1 / 6"), and empty results show a friendly
message instead of a blank page.

### Export your reading list

The toolbar's **Export list (.md)** button downloads `om-hub-reading-list.md` —
every card you've engaged with, grouped by **★ Liked → ✓ Visited → ✎ Notes**,
with links, status flags, and your notes. Each card appears once (in its
highest-priority group); cards with no engagement are omitted.

### Adding new content

Set `data-added` on any new card and everything updates automatically — the
banner, the "Added" stamp, the "New to you" pill for returning visitors, and
all counts:

```html
<div class="card" data-id="my-new-card" data-added="2026-08-03">
  ...
</div>
```

Returning visitors will see a "New to you" pill on it until their next visit.

### Accessibility & resilience

- Icon toggles carry `aria-label` / `aria-pressed`; keyboard focus shows a
  visible ring; all controls are real `<button>` elements.
- The "New to you" pulse respects `prefers-reduced-motion`.
- It's all progressive enhancement — with JavaScript off the page still works
  as a plain link gallery (notes/filters simply don't appear).

### Resetting visitor state

To clear everything a visitor has stored (handy while testing):

```js
['omhub.notes','omhub.visited','omhub.liked','omhub.lastSeen'].forEach(k=>localStorage.removeItem(k)); location.reload()
```

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
