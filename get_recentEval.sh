#!/bin/bash

# use qsearch on USAID site to get CSV of metadata for recent evaluation docs

# make function to url encode
function url_encode { perl -MURI::Escape -e 'print uri_escape($ARGV[0]); print "\n";' $1 ;}
baseurl="https://dec.usaid.gov/api/qsearch.ashx?q="
search='(documents.web_collection:("recent evaluations"))'
base64=$( echo -e "$search\c" | base64  )
qstring=$( url_encode "$base64" )
# written to pipe to sh so we can easily check URL
echo curl -s "${baseurl}${qstring}&rtype=CSV" | sh
