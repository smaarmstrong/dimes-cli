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
- `data/*.json` — the content, split per language and category (`la-nouns`,
  `grc-verbs`, `de-pronouns`, …). Every file is globbed, so add paradigms by
  editing or adding any `data/*.json`. Each is a list of cards:

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
  fill. For Greek, an optional `display` holds the polytonic form that is shown,
  while `answer` holds the romanisation that is matched.
- `./selfcheck` — validates every card: schema, unique ids, and a simulated
  drill in which each stored answer must score 100% with the engine's matcher.
  Run it after any data edit.

Progress (last score + date per card) is stored in
`~/.local/state/dimes-cli/history.json`.

## Content so far

- **Latin** (43 cards) — all five noun declensions incl. i-stems and neuters;
  the four regular conjugations plus -iō verbs and deponents; adjectives of both
  classes with comparative/superlative; personal, demonstrative, relative,
  interrogative and reflexive pronouns; irregular verbs (sum, possum, eō, ferō,
  volō/nōlō/mālō, fīō).
- **German** — definite-article declension, `sein`, `haben`, `werden`.
- **Greek (romanised)** — 1st/2nd declension (chōrā, logos), `eimi`, `luō`.
