#!/usr/local/bin/fish

shp2json $argv[1] |
    geoproject -n 'd3.geoAlbersUsa().scale(1300).translate([487.5, 305])' |
    ndjson-split 'd.features' |
    ndjson-filter 'd.properties.sov_a3 === "USA"' |
    ndjson-map 'delete d.properties.scalerank,
delete d.properties.featurecla,
delete d.properties.sov_a3,
delete d.properties.uident,
delete d.properties.add,
delete d.properties.natrlscale,
delete d.properties.continent,
d' >temp-map.ndjson
geo2topo -n overlay=temp-map.ndjson |
    toposimplify -p 1 -f |
    topoquantize 1e5 >railroads-topo.json
