include<cabinet_standards>;
use<kitchen_sink.scad>;

// https://www.homedepot.com/p/Ruvati-Drop-in-Stainless-Steel-33-in-Top-Mount-16-Gauge-Single-Bowl-Kitchen-Sink-RVH8001/302957655#overlay
kitchen_sink(countertop_width = 36,
             sink_width = 33,
             sink_depth = 22,
             sink_height = 10,
             cutout_width = 31, 
             cutout_depth = 18,
             cutout_placement_depth = 2);
