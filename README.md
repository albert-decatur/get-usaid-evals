USAID DEC Evaluation Documents
==============================

This repo helps you get metadata for USAID DEC evaluation documents, and also keeps the plain text of evaluation documents.
Under output/ you will find a TSV with metadata for all USAID evals called evals_2014-09-29.csv.
Also under output you can find [git_split_big](https://github.com/albert-decatur/git-split-big) zips for all those evals as text called eval_files.zip_zips/.
From this stage you could, for example:

* use Stanford NER to run named entity recognition (NER) for places, organizations, and people
* get a bag of words from each document and run tf-idf to find terms that distinguish documents from each other
* use Mallet to run LDA topic modelling or find meaningful n-grams

The script get_usaid_dec.sh just uses the USAID qsearch API.
You can hand it an arbitrary search string.
You can run this script in a loop by year like so:


```bash
outdir=output
rm -r $outdir 2>/dev/null
mkdir $outdir
for yr in $(seq 1947 2014)
do 
	./get_usaid_dec.sh "(Documents.Bibtype_Name:((\"Special Evaluation\") OR (\"Final Evaluation Report\"))) AND (Documents.Date_of_Publication_Freeforrm:($yr))" > $outdir/${yr}.csv
done
```

Or you could grab project evals by month if year breaks:


```bash
yr=2014
# note use of seq -w to pad 1 - 9 with leading zero
for c in $(seq -w 1 12);
do 
	# note use of printf to define n (next) month given c (current) month
	# this is to preserve leading zeroes in next month
	printf -v n '%02d' $((10#$c + 1))
	./get_usaid_dec.sh "(Documents.Bibtype_Name:((\"Special Evaluation\") OR (\"Final Evaluation Report\"))) AND datecreated:([${yr}${c}01000000 TO ${yr}${n}01000000])" > output/${yr}${c}${n}.csv
done
```

