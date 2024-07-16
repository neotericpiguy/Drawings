include<cabinet_standards>;
use<kitchen_sink.scad>;

// https://www.homedepot.com/p/Transolid-Workstation-33-in-Drop-in-Single-Bowl-Stainless-Steel-4-Hole-Kitchen-Sink-with-Accessories-KWSST332210-4/331029979
kitchen_sink(countertop_width = 36,
             sink_width = 33,
             sink_depth = 22,
             sink_height = 10,
             cutout_width = 31,
             cutout_depth = 17,
             cutout_placement_depth = 2);
