# dimes-cli

A console **grammar-matrix** drill for **Latin**, **Ancient Greek**, and
**German** — a terminal take on the [dimes](https://github.com/smaarmstrong)
apps. You fill in the blanks of a declension / conjugation table and it grades you.

Greek tables display polytonic Greek; you answer in plain ASCII, in either
**scholarly transliteration** (`chora`, `basileus`, `techne`) or **ELOT 743 /
modern style** (`chora`, `vasilefs`, `techni`) — no accent marks, ever.

## Use it

```bash
./dimes list                 # every paradigm, grouped by language
./dimes drill                # a spread across all three languages
./dimes drill latin          # one language (latin | greek | german)
./dimes drill latin-servus   # one specific card
./dimes drill greek -n 3     # limit to N cards
./dimes drill latin --blind  # hide the hint row too — fill the whole table
./dimes status               # your recent score per paradigm
```

At each blank you type the form. Matching is **case- and diacritic-insensitive**,
so you never need special characters: `servi` == `servī`, `schon` == `schön`,
`chora` == `chōrā`. Where a cell lists alternatives with `/` (`esti/estin`,
`essēs/forēs`), **any one of them** is accepted — you don't type the slash. `—`
marks a cell that doesn't apply.

By default the first row of each table is shown as a worked example and the rest
are blanks. Pass **`--blind`** (or `-b`) to hide that row too and drill every
cell. Press **Enter** to skip a blank (it's revealed, not marked wrong) and
**`q`** (or Ctrl-C) to stop. Your score for each finished card is saved as you
go, so you can quit any time — `./dimes status` and `./dimes list` show where you
stand.

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
  fill. For Greek, `display` holds the polytonic form that is shown, while
  `answer` holds the accepted ASCII transliterations, `/`-separated (scholarly
  and modern).
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
- **Ancient Greek** (45 cards) — 1st/2nd/3rd declension nouns incl. πόλις,
  βασιλεύς, γένος; adjectives incl. πᾶς and comparison; the article, personal,
  demonstrative, relative and interrogative/indefinite pronouns; λύω across the
  tense systems, the α/ε/ο contract verbs, deponents; -μι verbs (τίθημι, δίδωμι,
  ἵστημι, δείκνῡμι) and εἰμί, εἶμι, οἶδα, φημί, ἔρχομαι.
- **German** (56 cards) — der/die/das and ein-word declension, dieser/jeder/
  welcher; weak/strong/mixed adjective endings; 15 noun declensions covering
  umlaut/-en/-er/-s plurals, the n-declension (Junge, Student, Herr) and Name;
  personal/reflexive/relative/interrogative pronouns; sein/haben/werden, the six
  modals, and a spread of strong verbs, each conjugated through Präsens,
  Präteritum, Konjunktiv I/II, imperative and non-finite forms, plus a Perfekt
  auxiliary drill (ist gefahren / hat gegeben).
