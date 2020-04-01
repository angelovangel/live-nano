# on the client (where shiny should run), run
nc -l -k 127.0.0.1 3456 > test.csv
# IMPORTANT
make an index with -I 2-3x the size of the refseq db, see
https://github.com/lh3/minimap2/issues/141#issuecomment-378361824
and here:
https://github.com/lh3/minimap2/issues/15#issuecomment-324842627


tried the recommendation from lh
```
seqkit seq -m 3000 ~/Desktop/ncct/ID40-qscores/fastq-benchmark/sample5k.fastq | minimap2 -a -k15 -w10 -t 8 -K 100000 --secondary=no \
~/db/SpeciesTyping/Bacteria/genomeDB.fasta - | \
jsa.np.rtSpeciesTyping -bam - -index ~/db/SpeciesTyping/Bacteria/speciesIndex \
--read 50 -time 10 --qual 30 -out testdata/sample5k-filter3k.tsv
```

# on the server, run
```
minimap2 -a -x map-ont -t 6 -K 100000 --secondary=no \ 
~/db/SpeciesTyping/Bacteria/genomeDB.mmi data/*.fastq | \
jsa.np.rtSpeciesTyping -bam - -index ~/db/SpeciesTyping/Bacteria/speciesIndex \
--read 50 -time 10 -out - | \
jsa.util.streamClient --input - --server 127.0.0.1:3456
```

