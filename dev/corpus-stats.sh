GSED=`which gsed`;
if [[ "$GSED" == "" ]]; then
	GSED=`which sed`;
fi

GECHO=`which gecho`;
if [[ "$GECHO" == "" ]]; then
	GECHO=`which echo`;
fi

lang1path=`cat config.log | grep lang1= | $GSED 's/with-lang[^=]\+=/@/g' | cut -f2 -d'@' | $GSED 's/--//g' | $GSED 's/ *//g'`
lang1=fao
lang2path=`cat config.log | grep lang2b= | $GSED 's/with-lang[^=]\+=/@/g' | cut -f4 -d'@'`
lang2=`basename $lang2path | $GSED 's/apertium-//g'`
#pair=`cat config.log | grep ^PACKAGE= | cut -f2 -d"'" | $GSED 's/apertium-//g'`;
pair=fao-nob

tee /tmp/$pair.input | apertium -d . $pair-postchunk 2>/dev/null > /tmp/$pair.postchunk2.0
cat /tmp/$pair.postchunk2.0 | $GSED 's/\$/$\n/g' | $GSED 's/^ *//g' | $GSED 's/ *$//g' | grep -v '^ *$' > /tmp/$pair.postchunk2.1
cat /tmp/$pair.postchunk2.1 | lt-proc -g $pair.autogen.bin > /tmp/$pair.gen

total=`cat /tmp/$pair.postchunk2.1 | wc -l`
generr=`cat /tmp/$pair.gen | grep '#' | wc -l`;
unkerr=`cat /tmp/$pair.postchunk2.1 | grep '\*' | wc -l`;

cat /tmp/$pair.input | apertium-destxt | hfst-proc -w "$lang1path/analyser-mt-apertium-desc.und.hfstol" | apertium-retxt | $GSED 's/\$/$\n/g' | $GSED 's/^ *//g' | $GSED 's/ *$//g' | grep -v '^ *$' > /tmp/$pair.morph

untr_total=`cat /tmp/$pair.morph | wc -l`;
untr_known=`cat /tmp/$pair.morph | grep -v '\*' | wc -l`;

untrimmed=`$GECHO "(($untr_known/$untr_total)*100)" | bc -l | head -c 5`;
trimmedclean=`$GECHO "100-((($generr+$unkerr)/$total)*100)" | bc -l | head -c 5`;
trimmed=`$GECHO "100-(($unkerr/$total)*100)" | bc -l | head -c 5`;

$GECHO "$untr_total $untr_known // $total $unkerr $generr"
$GECHO -e "Untrimmed:\t$untrimmed %";
$GECHO -e "Trimmed:\t$trimmed %";
$GECHO -e "Clean  :\t$trimmedclean %";
