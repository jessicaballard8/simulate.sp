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
vdata d gnd! pwl(0ns 1.2v 1ns 1.2v 1.05ns 0v 3.98ns 0v 3.14ns 1.2v 4.10ns 1.2v 4.15ns 0v 5.15ns)
cout q gnd! 80f

$transient analysis
.tr 100ps 12ns
$example of parameter sweep, replace numeric value W of pfet with WP in invlvs.sp
$.tr 100ps 12ns sweep WP 1u 9u 0.5u

.measure tran trise trig v(d) val=0.6v fall=1 targ v(q) val=0.6v rise=1 $measure tlh at 0.6v
.measure tran tfall trig v(d) val=0.6v rise=1 targ v(q) val=0.6v fall=1 $measure tpl at 0.6v
.measure tavg param = '(trise+tfall)/2' $calculate average delay
.measure tdiff param='abs(trise-tfall)' $calculate delay difference
.measure delay param='max(trise,tfall)' $calculate worst case delay

$ method 1
.measure tran iavg avg i(vdd) from=0 to=10n $average current in one clock cycle
.measure energy param='1.2*iavg*10n' $calculate energy in one clock cycle
.measure edp1 param='abs(delay*energy)'

$ method 2
.measure tran t1 when v(d)=1.19 fall=1
.measure tran t2 when v(q)=1.19 rise=1
.measure tran t3 when v(d)=0.01 rise=1
.measure tran t4 when v(q)=0.01 fall=1
.measure tran i1 avg i(vdd) from=t1 to=t2 $average current when output rise
.measure tran i2 avg i(vdd) from=t3 to=t4 $average current when output fall
.measure energy1 param='1.2*i1*(t2-t1)' $calculate energy when output rise
.measure energy2 param='1.2*i2*(t4-t3)' $calculate energy when output fall
.measure energysum param='energy1+energy2'
.measure edp2 param='abs(delay*energysum)'

.end
