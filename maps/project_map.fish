#!/usr/local/bin/fish

geoproject 'd3.geoAlbersUsa().scale(1300).translate([487.5, 305])' < $argv[1] > usa.json