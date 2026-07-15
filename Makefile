# Convenience wrappers around ./dimes, so you can just reach for `make`.
#
#     make learn     # meet new words, then get quizzed to lock them in
#     make vocab     # review the words that are due (spaced repetition)
#     make words     # list every word, its meaning, and what's due
#     make drill     # fill in a grammar paradigm table
#
# The argless targets cover all three languages. For one language or one card,
# fall through to ./dimes directly:  ./dimes learn latin  ·  ./dimes drill greek

DIMES := ./dimes
.DEFAULT_GOAL := help

.PHONY: help learn vocab words drill list status cli

help: ; @printf 'dimes — just run one of:\n\n  make learn    meet new words, then get quizzed to lock them in\n  make vocab    review the words that are due (spaced repetition)\n  make words    list every word, its meaning, and what is due\n  make drill    fill in a grammar paradigm table\n  make list     list the grammar paradigms\n  make status   your recent scores\n\nOne language / one card:  ./dimes learn latin  |  ./dimes drill latin-servus\nFull CLI:  ./dimes help\n'

learn:  ; @$(DIMES) learn
vocab:  ; @$(DIMES) vocab
words:  ; @$(DIMES) vocab list
drill:  ; @$(DIMES) drill
list:   ; @$(DIMES) list
status: ; @$(DIMES) status
cli:    ; @$(DIMES) help
