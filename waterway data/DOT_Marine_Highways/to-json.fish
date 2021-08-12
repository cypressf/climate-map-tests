#!/usr/local/bin/fish

shp2json $argv[1] |
geoproject -n 'd3.geoAlbersUsa().scale(1300).translate([487.5, 305])' |
ndjson-split 'd.features' |
ndjson-map 'delete d.properties.OBJECTID_1,
delete d.properties.objectid,
delete d.properties.linknum,
delete d.properties.totalup,
delete d.properties.totaldown,
delete d.properties.mh_id,
delete d.properties.ww_name,
delete d.properties.st_usps,
delete d.properties.st_fips,
delete d.properties.st_usps_2,
delete d.properties.st_fips_2,
delete d.properties.applicant,
delete d.properties.landside_r,
delete d.properties.st_length_,
delete d.properties.ShapeSTLen,
d' > temp-map.ndjson
geo2topo -n waterways=temp-map.ndjson |
toposimplify -p -1 -f |
topoquantize 1e5 > waterways-topo.json