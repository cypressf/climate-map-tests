#!/usr/local/bin/fish

shp2json "shape files/CRITHAB_LINE.shp" |
    geoproject -n 'd3.geoAlbersUsa().scale(1300).translate([487.5, 305])' |
    ndjson-split 'd.features' |
    ndjson-map 'delete d.properties.singlmulti,
delete d.properties.comname,
delete d.properties.sciname,
delete d.properties.spcode,
delete d.properties.vipcode,
delete d.properties.unit,
delete d.properties.subunit,
delete d.properties.unitname,
delete d.properties.subunitnam,
delete d.properties.status,
delete d.properties.leadoffice,
delete d.properties.coopoffice,
delete d.properties.coopofmore,
delete d.properties.fedreg,
delete d.properties.pubdate,
delete d.properties.effectdate,
delete d.properties.vacatedate,
delete d.properties.accuracy,
delete d.properties.source_id,
delete d.properties.objectid,
delete d.properties.listing_st,
d' >temp-map.ndjson
geo2topo -n critical-habitats=temp-map.ndjson |
    toposimplify -p 1 -f |
    topoquantize 1e5 >critical-habitats-topo.json
