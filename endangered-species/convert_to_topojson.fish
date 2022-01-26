#!/usr/bin/env fish

shp2json "shape files/endangerspecies2.shp" |
    geoproject -n 'd3.geoAlbersUsa().scale(1300).translate([487.5, 305])' |
    ndjson-split 'd.features' |
    ndjson-map 'delete d.properties.OBJID,
    delete d.properties.decimalLat,
    delete d.properties.decimalLon,
    delete d.properties.kingdom,
    delete d.properties.phylum,
    delete d.properties.class,
    delete d.properties.order_,
    delete d.properties.family,
    delete d.properties.genus,
    delete d.properties.species,
    delete d.properties.stateProvi,
    d' >temp-map.ndjson
geo2topo -n overlay=temp-map.ndjson |
    toposimplify -p 1 -f |
    topoquantize 1e5 >endangered-species-topo.json
