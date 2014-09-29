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
