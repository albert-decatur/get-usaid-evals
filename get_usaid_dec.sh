#!/bin/bash

# use qsearch on USAID site to get CSV of metadata for recent evaluation docs
# user args: 1) USAID qsearch string to query.  NB: user must escape quotes as necessary
# example use: $0 '(documents.web_collection:("recent evaluations"))'

# make function to url encode
function url_encode { perl -MURI::Escape -e 'print uri_escape($ARGV[0]); print "\n";' $1 ;}
baseurl="https://dec.usaid.gov/api/qsearch.ashx?q="
search=$1
base64=$( echo -e "$search\c" | base64  | tr -d '\n' )
qstring=$( url_encode "$base64" )
curl -s "${baseurl}${qstring}&rtype=CSV"
