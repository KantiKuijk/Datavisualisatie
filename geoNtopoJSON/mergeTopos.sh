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
	topo2geo -i "${t}" `echo ${o//toponame/${t%.topojson}}`
done
geojson-merge .mergeTopos/*.json > "${tempDir}/merged.json"
geo2topo "${tempDir}/merged.json" > merged.topojson
rm -r "${tempDir}"
