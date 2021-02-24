#!/usr/local/bin/fish

shp2json $argv[1] |
geoproject 'd3.geoAlbersUsa().fitSize([975, 610], d)' |
ndjson-split 'd.features' > temp-map.ndjson
geo2topo -n roads=temp-map.ndjson |
toposimplify -p -1 -f |
topoquantize 1e5 > usa-topo.json