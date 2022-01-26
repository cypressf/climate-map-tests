#!/usr/bin/env fish
cat "texas and louisiana.geojson" |
    geoproject 'd3.geoAlbersUsa().scale(1300).translate([487.5, 305])' >temp-map.geojson
geo2topo toxic-sites=temp-map.geojson |
    toposimplify -p 1 -f |
    topoquantize 1e5 >toxic-sites-topo.json
