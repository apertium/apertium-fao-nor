#!/bin/sh
# https://wiki.apertium.org/wiki/Asturian#Calculating_coverage


# Example use:
# zcat corpa/en.crp.txt.gz | sh corpus-stat.sh


#CMD="cat corpa/en.crp.txt"
CMD="cat"

F=/tmp/corpus-stat-res.txt

# Calculate the number of tokenised words in the corpus:
# for some reason putting the newline in directly doesn't work, so two seds
$CMD | apertium-destxt | lt-proc ../fao-nob.automorf.hfst | apertium-retxt | gsed 's/\$[^^]*\^/$^/g' | gsed 's/\$\^/$\
^/g' > $F

NUMWORDS=`cat $F | wc -l`
echo "Number of tokenised words in the corpus: $NUMWORDS"



# Calculate the number of words that are not unknown

NUMKNOWNWORDS=`cat $F | grep -v '\*' | wc -l`
echo "Number of known words in the corpus: $NUMKNOWNWORDS"


# Calculate the coverage

COVERAGE=`calc "round($NUMKNOWNWORDS/$NUMWORDS*1000)/10"`
echo "Coverage: $COVERAGE %"

#If you don't have calc, change the above line to:
#COVERAGE=$(perl -e 'print int($ARGV[0]/$ARGV[1]*1000)/10;' $NUMKNOWNWORDS $NUMWORDS)

# Show the top-ten unknown words.

echo "Top unknown words in the corpus:"
cat $F | grep '\*' | sort -f | uniq -c | sort -gr | head -10
