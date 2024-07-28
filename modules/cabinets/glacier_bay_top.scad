include<cabinet_standards>;
use<kitchen_sink.scad>;

// https://www.homedepot.com/p/Glacier-Bay-33-in-Drop-In-Single-Bowl-18-Gauge-Gunmetal-black-Stainless-Steel-Workstation-Kitchen-Sink-with-Accessories-ACS3322A1TS/328548124#overlay
kitchen_sink(countertop_width = 36,
             sink_width = 33,
             sink_depth = 22,
             sink_height = 10,
             cutout_width = 31,
             cutout_depth = 17.8,
             cutout_placement_depth = 2);
