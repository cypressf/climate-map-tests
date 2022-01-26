#!/usr/bin/env fish

shp2json $argv[1] |
    geoproject -n 'd3.geoAlbersUsa().scale(1300).translate([487.5, 305])' |
    ndjson-split 'd.features' |
    ndjson-filter 'd.properties.sov_a3 === "USA"' |
    ndjson-map 'delete d.properties.featurecla,
delete d.properties.sov_a3,
delete d.properties.note,
delete d.properties.edited,
delete d.properties.namealt,
delete d.properties.namealtt,
delete d.properties.routeraw,
delete d.properties.question,
delete d.properties.length_km,
delete d.properties.toll,
delete d.properties.ne_part,
delete d.properties.label,
delete d.properties.label2,
delete d.properties.local,
delete d.properties.localtype,
delete d.properties.localalt,
delete d.properties.labelrank,
delete d.properties.ignore,
delete d.properties.add,
delete d.properties.rwdb_rd_id,
delete d.properties.orig_fid,
delete d.properties.prefix,
delete d.properties.uident,
delete d.properties.continent,
delete d.properties.expressway,
delete d.properties.min_zoom,
delete d.properties.min_label,
delete d.properties.name,
delete d.properties.level,
delete d.properties.type,
d' >temp-map.ndjson
geo2topo -n overlay=temp-map.ndjson |
    toposimplify -p 1 -f |
    topoquantize 1e5 >roads-topo.json
