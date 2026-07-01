# dimes-cli

A console **grammar-matrix** drill for **German**, **Latin**, and **Romanised
Ancient Greek** — a terminal take on the [dimes](https://github.com/smaarmstrong)
apps. You fill in the blanks of a declension / conjugation table and it grades you.

Ancient Greek is **romanised** on purpose: it's a CLI, so you type `chora` /
`chōrā` at the prompt instead of wrestling polytonic Greek input.

## Use it

```bash
./dimes list                 # every paradigm, grouped by language
./dimes drill                # a spread across all three languages
./dimes drill latin          # one language (latin | german | greek)
./dimes drill latin-servus   # one specific card
./dimes drill greek -n 3     # limit to N cards
./dimes status               # your recent score per paradigm
```

At each blank you type the form. Matching is **case- and diacritic-insensitive**
(`servi` == `servī`, `chora` == `chōrā`), `/` marks accepted alternatives
(`esti/estin`), and `—` marks a cell that doesn't apply.

## How it works

- `dimes` — a single Python 3 script (no dependencies; Python 3 ships with most
  systems). Renders each matrix as an ASCII table, prompts each hidden cell, then
  re-renders with ✓ / correction and a score.
- `data/*.json` — the content, one file per language (`la`, `de`, `grc`). Each is a
  list of cards:

  ```json
  {
    "id": "latin-servus",
    "word": "servus",
    "language": "Latin",
    "category": "noun · 2nd declension masculine",
    "matrices": [{
      "label": "servus, servī (m.)",
      "rowHeaders": ["Nominative", "..."],
      "columnHeaders": ["Singular", "Plural"],
      "cells": [[{"answer": "servus", "hidden": false}, {"answer": "servī", "hidden": false}], ...]
    }]
  }
  ```

  `hidden: false` cells are shown as hints; `hidden: true` cells are the blanks you
  fill. Add paradigms by editing/adding a `data/*.json` file — no code changes.

Progress (last score + date per card) is stored in
`~/.local/state/dimes-cli/history.json`.

## Content so far

- **Latin** — 1st/2nd declension nouns (puella, servus, bellum), 1st-conjugation
  `amō`, irregular `sum`.
- **German** — definite-article declension, `sein`, `haben`, `werden`.
- **Greek (romanised)** — 1st/2nd declension (chōrā, logos), `eimi`, `luō`.

A starter set — the data format makes it easy to keep adding paradigms.
