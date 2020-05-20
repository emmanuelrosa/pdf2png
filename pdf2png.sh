#! /usr/bin/env bash

function showusage() {
	echo "USAGE: pdf2png PDFFILE"
}

if [ "${1}" == "" ]
then
	showusage
	exit
fi

dir=$(dirname -z "${1}")
file=$(basename -z -s .pdf "${1}" .pdf)
outfile=${dir}/${file}.png

convert -density 300 "${1}" -resize 1920x1080 "${outfile}"
