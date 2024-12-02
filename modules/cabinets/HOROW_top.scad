include<cabinet_standards>;
use<kitchen_sink.scad>;

// https://www.homedepot.com/p/HOROW-Drop-in-Stainless-Steel-33-in-Workstation-Ledge-Topmount-Kitchen-Sink-18-Gauge-2-Hole-Single-Bowl-with-Integrated-Ledge-HR-S3322UW/324822283#overlay
kitchen_sink(countertop_width = 36,
             sink_width = 33,
             sink_depth = 22,
             sink_height = 10,
             cutout_width = 31,
             cutout_depth = 17,
             cutout_placement_depth = 2);
