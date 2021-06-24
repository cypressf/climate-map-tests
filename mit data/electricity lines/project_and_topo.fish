#!/usr/local/bin/fish
geoproject 'd3.geoAlbersUsa().scale(1300).translate([487.5, 305])' $argv[1] |
    ndjson-split 'd.features' |
    ndjson-map 'delete d.properties.OBJECTID,
delete d.properties.ID,
delete d.properties.TYPE,
delete d.properties.STATUS,
delete d.properties.NAICS_CODE,
delete d.properties.NAICS_DESC,
delete d.properties.SOURCE,
delete d.properties.SOURCEDATE,
delete d.properties.VAL_METHOD,
delete d.properties.VAL_DATE,
delete d.properties.OWNER,
delete d.properties.VOLTAGE,
delete d.properties.VOLT_CLASS,
delete d.properties.INFERRED,
delete d.properties.SUB_1,
delete d.properties.SUB_2,
delete d.properties.SHAPE_Length,
d' >temp-map.ndjson
geo2topo -n electric_lines=temp-map.ndjson |
    toposimplify -p -1 -f |
    topoquantize 1e5 >electric-lines-topo.json
