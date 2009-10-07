#!/bin/bash
#
# Regenerate scored files, after changing calc-levenshtein.py

cat noun.list | grep -v '<Prop>' | python calc-levenshtein.py   | sort -gr > noun.scored.list
cat vblex.list | python calc-levenshtein.py | sort -gr > vblex.scored.list 
cat adv.list | python calc-levenshtein.py | sort -gr > adv.scored.list
cat prep.list | python calc-levenshtein.py | sort -gr > prep.scored.list
cat adj.list | python calc-levenshtein.py | sort -gr > adj.scored.list
