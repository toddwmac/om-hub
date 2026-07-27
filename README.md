# OM Hub

**OM Hub** — a small static site on GitHub Pages. It hosts data-driven
startup report pages and links out to a curated set of external AI showcases,
research, and analytics resources. Every link opens in a new tab.

## Adding content — quick cheat sheet

Everything lives in one file: **`index.html`**. Add a `<div class="card">` inside the chosen section's `.grid`, set two attributes, and ship.

1. **Pick a section** (`data-sec`): `hot-topics` · `working-papers` · `startup-reports` · `arena-showcases` · `research-resources`.
2. **Two required attributes** on the card: `data-id="<unique-slug>"` (never rename it later) and `data-added="YYYY-MM-DD"` (today). `data-added` auto-updates the "Latest addition" banner, the per-card "Added" stamp, the "New to you" pill, and all counts.
3. **The link** sits inside `<div class="actions">`:
   - external site → `href="https://example.com/"`
   - local page → `href="Foo.html"` (commit the file too)
4. **Keep in sync** → the note button's `aria-controls="YOUR-ID-note"` must match its `<div class="note-area" id="YOUR-ID-note">`.
5. **Bump the count** → set `N` in that section's `<span class="count"><b class="num">N</b> …</span>` to match the number of cards.
6. **Ship** → `.\deploy.ps1 -m "Add <title>"`.

Full templates, rules, and a copy-paste agent prompt live in the **Adding content — full reference** section below.

## Live site

**https://toddwmac.github.io/om-hub/**

## What's on the site

`index.html` is the landing page — it links to everything: local report pages,
AI Arena showcases, and external research/analytics resources. The specific
cards change over time, so the **landing page is the source of truth for current
content**; this README documents how the site works and how to add to it.

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

### Adding content — full reference (for humans & agents)

The whole site is one static file: **`index.html`**. There's no build step and no database — adding content means adding a card. Cards live inside collapsible `<section class="sec">` blocks, each containing a `<div class="grid">`. Drop a new `<div class="card">` into the grid of the section it belongs to.

**Sections** (`data-sec` → heading):

| `data-sec` | Heading | Typical content |
|---|---|---|
| `hot-topics` | Hot Topics | Featured / timely items |
| `working-papers` | AI Working Papers | Papers, often with audio + PDF links |
| `startup-reports` | Startup Reports | Local report pages |
| `arena-showcases` | AI Arena Showcases | External Arena-built pages |
| `research-resources` | Interesting Research and Analytics Resources | External reading / reference sites |

**Two attributes every card needs** on the `<div class="card">`:

- `data-id="<unique-slug>"` — a stable, unique id (e.g. `your-card-slug`). The browser's visited / liked / notes state is keyed off it, so make it unique and **never rename it** after it's published.
- `data-added="YYYY-MM-DD"` — the publish date (today, for new content). This is the field that makes the site feel alive: setting it **automatically** updates the "Latest addition" header banner, the per-card "Added …" stamp, the "New to you" pill for returning visitors, and every count. Don't hand-write the date text — it's generated from this attribute.

**Template — external link card** (copy and edit):

```html
<div class="card" data-id="UNIQUE-SLUG" data-added="2026-07-27">
  <span class="tag">Routing</span>
  <h3>Title Goes Here</h3>
  <p>One or two sentences: what this is and why it's worth a click.</p>
  <span class="note">Optional editorial one-liner (your take). Omit this whole line if you don't want one.</span>
  <div class="actions">
    <a class="btn" href="https://example.com/" target="_blank" rel="noopener noreferrer">Open &#8599;</a>
  </div>
  <div class="notebox">
    <div class="ntoggle-row"><button type="button" class="note-toggle" aria-expanded="false" aria-controls="UNIQUE-SLUG-note" title="Add a note">&#9998;<span class="vh"> Note</span><span class="dot" aria-hidden="true"></span></button></div>
    <div class="note-area" id="UNIQUE-SLUG-note" hidden><textarea rows="2" placeholder="Note, question, or comment — saved on this device only."></textarea></div>
  </div>
</div>
```

**Local file page** (a report HTML file committed to this repo): identical template, but `href` is just the filename — and the file must exist in the repo:

```html
<a class="btn" href="your-report.html" target="_blank" rel="noopener noreferrer">Open report &#8599;</a>
```

**Multiple links** (e.g. "Listen" + "Read paper"): put more than one `<a class="btn">` inside the same `<div class="actions">`:

```html
<div class="actions">
  <a class="btn" href="https://..." target="_blank" rel="noopener noreferrer">Listen (audio overview) &#8599;</a>
  <a class="btn" href="https://..." target="_blank" rel="noopener noreferrer">Read paper &#8599;</a>
</div>
```

**Color accent (optional):** add `gold`, `rose`, or `alt` to the class, e.g. `<div class="card gold" …>`. Liked cards get a rose edge on top of whichever accent you choose.

**Two things that are easy to miss — both required:**

1. **Keep `aria-controls` and `id` in sync.** The note button's `aria-controls="UNIQUE-SLUG-note"` must exactly match its note-area's `id="UNIQUE-SLUG-note"`. Follow the `{data-id}-note` convention and they'll match by construction.
2. **Update the section count.** Every section header carries `<span class="count"><b class="num">N</b> …</span>` — set `N` to the number of cards in that grid so the header badge and the "visible / total" counts stay correct.

**Publish:** a commit + push is all it takes; GitHub Pages rebuilds on push to `main`:

```powershell
.\deploy.ps1 -m "Add <title>"   # omit -m for an auto timestamp message
```

**Hand it to an agent.** Fill in the brackets and paste:

> Add a card to the `<data-sec>` section in `index.html` (repo root). Title: `<...>`. URL: `<...>`. Tag: `<...>`. Use today's date for `data-added`, pick a unique `data-id`, and follow the "Adding content — full reference" section of README.md exactly — including the `aria-controls`/`id` sync and the section-count update. Leave it uncommitted, or run `.\deploy.ps1 -m "Add <title>"` to publish.

Returning visitors will see a "New to you" pill on a freshly added card until their next visit.

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
