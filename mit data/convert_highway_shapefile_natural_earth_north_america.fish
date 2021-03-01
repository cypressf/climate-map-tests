#!/usr/local/bin/fish

shp2json $argv[1] |
geoproject 'd3.geoAlbersUsa().fitSize([975, 610], d)' |
ndjson-split 'd.features' |
ndjson-filter 'd.properties.country === "United States"' |
ndjson-map 'delete d.properties.prefix,
delete d.properties.number,
delete d.properties.class,
delete d.properties.divided,
delete d.properties.country,
delete d.properties.state,
delete d.properties.note,
delete d.properties.uident,
delete d.properties.length,
delete d.properties.rank,
delete d.properties.continent,
d' > temp-map.ndjson
geo2topo -n roads=temp-map.ndjson |
toposimplify -p -1 -f |
topoquantize 1e5 > roads-topo.json