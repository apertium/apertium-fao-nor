#!/usr/bin/python
# coding=utf-8
# -*- encoding: utf-8 -*-

import sys, codecs, copy, commands;

sys.stdin  = codecs.getreader('utf-8')(sys.stdin);
sys.stdout = codecs.getwriter('utf-8')(sys.stdout);
sys.stderr = codecs.getwriter('utf-8')(sys.stderr);

def levenshtein(a,b):
    "Calculates the Levenshtein distance between a and b."
    a = a.lower();
    b = b.lower();
    n, m = len(a), len(b)
    if n > m:
        # Make sure n <= m, to use O(min(n,m)) space
        a,b = b,a
        n,m = m,n
        
    current = range(n+1)
    for i in range(1,m+1):
        previous, current = current, [i]+[0]*n
        for j in range(1,n+1):
            add, delete = previous[j]+1, current[j-1]+1
            change = previous[j-1]
            if a[j-1] != b[i-1]:
                change = change + 1
            current[j] = min(add, delete, change)
            
    return float(current[n]) + 1;

# Lists of replace operations for common orthographic or cognate 
# differences between Faroese and Icelandic.

def fao2nob(s): #{
	out = s;

	#out = out.replace(u'ø', u'ö');

	return out;
#}

for line in sys.stdin.read().split('\n'): #{
	if len(line) < 1: #{
		continue;
	#}
	row = line.split(' ');

	#print row[0] + ' ' + str(float(1 / levenshtein(row[1].split('<')[0], row[2].split('<')[0]))) + ' ' + row[1] + ' ' + row[2];

	# prob = probability from GIZA++
	# lev = 1 / levenshtein distance
	lev = float(1 / levenshtein(row[1].split('<')[0], fao2nob(row[2].split('<')[0])));
	prob = float(row[0]);

	# we multiply the probability by the levenshtein distance to downweight
	# unlikely (read non-cognate) translations
	
	#print str(prob * lev) + ' ' + row[1] + ' ' + row[2];
	print '%5f %s %s' % ((prob * lev), row[1], row[2]);
#}
