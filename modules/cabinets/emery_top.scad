include<cabinet_standards>;
use<kitchen_sink.scad>;

// https://www.homedepot.com/p/Glacier-Bay-Dolancourt-Tight-Radius-33-in-Drop-In-Single-Bowl-18G-Stainless-Steel-Workstation-Kitchen-Sink-with-Spring-Neck-Faucet-FSD2R3322B1SA1/323275403#overlay
kitchen_sink(countertop_width = 36,
             sink_width = 33,
             sink_depth = 22,
             sink_height = 10,
             cutout_width = 30 + 1 / 2,
             cutout_depth = 16,
             cutout_placement_depth = 2);
