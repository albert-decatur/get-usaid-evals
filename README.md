get USAID DEC eval
==================

Get metadata for USAID DEC evaluation documents.
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
