include<cabinet_standards>;
use<kitchen_sink.scad>;

// https://www.homedepot.com/p/KRAUS-Loften-33-in-Drop-In-Undermount-Single-Bowl-18-Gauge-Stainless-Steel-Kitchen-Sink-with-Pull-Down-Faucet-KCH-1000-H/326001240#overlay
kitchen_sink(countertop_width = 36,
             sink_width = 33,
             sink_depth = 22,
             sink_height = 9,
             cutout_width = 32.25,
             cutout_depth = 21.5,
             cutout_placement_depth = 2);
