#!/usr/local/bin/fish

shp2json $argv[1] |
geoproject 'd3.geoAlbersUsa().fitSize([975, 610], d)' |
ndjson-split 'd.features' |
ndjson-map 'd.id = d.properties.GEOID, d' > temp-map.ndjson
geo2topo -n counties=temp-map.ndjson |
toposimplify -p -1 -f |
topoquantize 1e5 |
topomerge -k 'd.id.slice(0,2)' states=counties |
topomerge --mesh -f 'a !== b' states=states > usa-topo.json