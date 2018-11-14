$example HSPICE setup file

$transistor model
.include "/home/cad/kits/IBM_CMRF8SF-LM013/IBM_PDK/cmrf8sf/V1.2.0.0LM/HSPICE/models/model013.lib_inc"
.include "/home/eng/j/jxb150730/cad/cadence/dfflvs.sp"

.global vdd! gnd!
.option post runlvl=5

xi clk d r q dff

vdd vdd! gnd! 1.2v
vreset r gnd! 0v
vclock clk gnd! pwl(0ns 1.2v 1ns 1.2v 1.05ns 0v 2.05ns 0v 2.10ns 1.2v 3.10ns 1.2v 3.15ns 0v 4.15ns 0v 4.20ns 1.2v 5.20ns 1.2v 5.25ns 0v 6.25ns 0v 6.3ns 1.2v 7.3ns 1.2v 7.35ns 0v 8.35ns 0v 8.4ns 1.2v 9.4ns 1.2v)
vdata d gnd! pwl(0ns 1.2v 1ns 1.2v 1.05ns 0v 3.088ns 0v 3.138ns 1.2v 5ns 1.2v 5.05ns 0v 6.5ns 0v 6.55ns 1.2v 7.309ns 1.2v 7.359ns 0 8.45ns 0v)
cout q gnd! 80f

.end
