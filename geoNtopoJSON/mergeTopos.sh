#!/bin/zsh
tempDir='.mergeTopos'
rm -r "${tempDir}" 2>/dev/null
mkdir -p "${tempDir}"


features=(`topo2geo -i "$1" -l`)
o=""
for f in ${features[@]} ; do
	o+=" ${f}=${tempDir}/toponame.${f}.json"
done

for t in $@ ; do
	topo2geo -i "${t}" `echo "${o//toponame/${t%.topojson}}"`
done

o=""
for f in ${features[@]} ; do
	geojson-merge .mergeTopos/*.${f}.json > "${tempDir}/merged.${f}.json"
	o+=" ${f}=${tempDir}/merged.${f}.json"
done
geo2topo `echo "${o}"` > merged.topojson
rm -r "${tempDir}"
