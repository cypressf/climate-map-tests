#!/usr/bin/env fish

topo2geo countries.json <world-unprojected.json
geoproject 'd3.geoNaturalEarth2()' <countries.json >temp-countries.json
geo2topo countries=temp-countries.json |
    toposimplify -p 1 -f |
    topoquantize 1e5 >world.json
