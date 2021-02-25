#!/usr/local/bin/fish

shp2json $argv[1] |
geoproject 'd3.geoAlbersUsa().fitSize([975, 610], d)' |
ndjson-split 'd.features' |
ndjson-map 'delete d.properties.OBJECTID,
delete d.properties.PREFIX,
delete d.properties.PRETYPE,
delete d.properties.NAME,
delete d.properties.TYPE,
delete d.properties.SUFFIX,
delete d.properties.CLASS,
delete d.properties.CLASS_RTE,
delete d.properties.HWY_TYPE,
delete d.properties.HWY_SYMBOL,
delete d.properties.Shape_Leng,
d' > temp-map.ndjson
geo2topo -n roads=temp-map.ndjson |
toposimplify -p -1 -f |
topoquantize 1e5 > roads-topo.json