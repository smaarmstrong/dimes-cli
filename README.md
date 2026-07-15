# dimes-cli

A console trainer for **Latin**, **Ancient Greek**, and **German** — a terminal
take on the [dimes](https://github.com/smaarmstrong) apps. Two things to practise:

- **Vocabulary** — meet words and review them on a spaced-repetition schedule.
- **Grammar** — fill in the blanks of a declension / conjugation table.

You always answer in plain ASCII. Matching is case- and diacritic-insensitive,
and Greek is typed transliterated, in either **scholarly** (`chora`, `basileus`,
`techne`) or **ELOT 743 / modern** style (`chora`, `vasilefs`, `techni`) — no
accent marks, ever.

## Learn vocabulary

```bash
./dimes learn                # meet a few new words, then get quizzed to lock them in
./dimes learn latin          # ...in one language (latin | greek | german)
./dimes vocab                # review the words that are due today
./dimes vocab greek          # ...in one language
./dimes vocab list           # every word, its meaning, and what's due
```

`learn` shows each new word with its meaning and dictionary form (and, where a
matching paradigm exists, points you at `drill` for its full table), then asks
you to produce it. `vocab` is the daily driver: it auto-picks the words that are
**due**, quizzes each in a random direction — the word ⇒ you type the English
meaning, or the meaning ⇒ you type the word — and reschedules it further out each
time you get it right (1, 3, 7, 16, 35, 75 days…), or brings it straight back if
you miss it. Progress lives in `~/.local/state/dimes-cli/vocab.json`.

## Drill grammar

```bash
./dimes list                 # every paradigm, grouped by language
./dimes drill                # a spread across all three languages
./dimes drill latin          # one language (latin | greek | german)
./dimes drill latin-servus   # one specific card
./dimes drill greek -n 3     # limit to N cards
./dimes drill latin --hints  # reveal the first row as a worked example
./dimes status               # your recent score per paradigm
```

At each blank you type the form. Matching is **case- and diacritic-insensitive**,
so you never need special characters: `servi` == `servī`, `schon` == `schön`,
`chora` == `chōrā`. Where a cell lists alternatives with `/` (`esti/estin`,
`essēs/forēs`), **any one of them** is accepted — you don't type the slash. `—`
marks a cell that doesn't apply.

Every cell of the table is a blank to fill — nothing in the paradigm is given
away. Pass **`--hints`** (or `-H`) to reveal the first row as a worked example.
Press **Enter** to skip a blank (it's revealed, not marked wrong) and **`q`** (or
Ctrl-C) to stop. Your score for each finished card is saved as you go, so you can
quit any time — `./dimes status` and `./dimes list` show where you stand.

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
- `data/vocab/*.json` — the vocabulary, loaded separately from the grammar
  paradigms. Each is a list of word entries:

  ```json
  {
    "id": "la-vocab-rex",
    "language": "Latin",
    "headword": "rex",
    "display": "rēx",
    "info": "rēx, rēgis, m.",
    "pos": "noun",
    "meaning": "king",
    "answer": "rex",
    "grammar": "latin-rex"
  }
  ```

  `meaning` is the accepted English (list synonyms with `/`); `answer` is the
  accepted ASCII form(s) you type for the word (`/`-separated — for Greek, the
  scholarly and modern transliterations; for German nouns, with and without the
  article). `info` is the dictionary form shown while teaching. Optional
  `grammar` links to a paradigm card id so `learn` can point you at its `drill`.
- `./selfcheck` — validates every grammar card **and** every vocab entry: schema,
  unique ids, a simulated drill in which each stored answer scores 100% with the
  engine's matcher, ASCII-typable answers (and pure-ASCII Greek), and that every
  `grammar` link resolves. Run it after any data edit.

Progress (last score + date per card) is stored in
`~/.local/state/dimes-cli/history.json`.

## Content so far

**Vocabulary — 285 words** (Latin 95, Ancient Greek 87, German 103). Each has an
English meaning, a dictionary/citation form, and an ASCII answer (Greek in both
scholarly and modern transliteration; German nouns with or without the article).
Roughly half are common high-frequency words; the rest are the headwords of the
grammar paradigms below, so `learn` can hand you straight to `drill` for a word's
full table. Meet them with `dimes learn`, review with `dimes vocab`.

### Grammar paradigms

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
