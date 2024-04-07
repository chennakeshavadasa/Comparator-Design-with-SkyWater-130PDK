v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
T {Nithin P
https://www.linkedin.com/in/nithin-purushothama-70664727b/} 10 -1140 0 0 1 1 {}
N 540 -570 600 -570 {
lab=ADJ}
N 600 -570 600 -500 {
lab=ADJ}
N 600 -570 690 -570 {
lab=ADJ}
N 350 -570 460 -570 {
lab=DIFFOUT_N}
C {devices/title.sym} 160 -40 0 0 {name=l1 author="NITHIN P"}
C {devices/lab_pin.sym} 490 -350 0 0 {name=p2 lab=PLUS}
C {devices/lab_pin.sym} 490 -290 0 0 {name=p3 lab=MINUS}
C {devices/lab_pin.sym} 490 -230 0 0 {name=p4 lab=EN_N}
C {devices/lab_pin.sym} 490 -250 0 0 {name=p5 lab=ADJ}
C {sky130_tests/not.sym} 460 -740 0 0 {name=x1 m=1 
+ W_N=1 L_N=0.15 W_P=2 L_P=0.15 
+ VCCPIN=VCC VSSPIN=VSS}
C {devices/lab_pin.sym} 500 -740 0 1 {name=p9 lab=START_N}
C {devices/code.sym} 20 -480 0 0 {name=STIMULI only_toplevel=false value="* .option SCALE=1e-6
.option method=gear

* this experimental option enables mos model bin
* selection based on W/NF instead of W
.option wnflag=1


.param VCCGAUSS = agauss(1.8, 0.05, 1)
.param VCC = 'VCCGAUSS'
** use of following line to remove VCC variations
*.param VCC =1.8

.param TEMPGAUSS = agauss(40, 30, 1)
.option temp = 'TEMPGAUSS'
** use of following line to remove temperature variations
*  .option temp =25

.include stimuli_tb_opamp.cir
.control
 option seed=9
 let run=0
 dowhile run <= 100
   save all
   tran 1n 4000n uic 
   remzerovec
   write tb_opamp.raw
   set appendwrite
   reset
   let run = run + 1
 end
.endc






 






  




"}
C {sky130_tests/passgate.sym} 500 -570 0 0 {name=x6 W_N=0.5 L_N=0.15 W_P=0.5 L_P=0.15 VCCBPIN=VCC VSSBPIN=VSS m=1}
C {devices/lab_pin.sym} 500 -540 0 0 {name=p13 sig_type=std_logic lab=START_N}
C {sky130_fd_pr/cap_mim_m3_2.sym} 600 -470 0 0 {name=C1 model=cap_mim_m3_2 W=10 L=10 MF=5 spiceprefix=X}
C {devices/lab_pin.sym} 600 -440 0 0 {name=p14 sig_type=std_logic lab=VSS}
C {devices/lab_pin.sym} 690 -570 0 1 {name=p16 sig_type=std_logic lab=ADJ}
C {devices/lab_pin.sym} 420 -740 0 0 {name=p8 sig_type=std_logic lab=START}
C {devices/lab_pin.sym} 500 -600 0 0 {name=p12 sig_type=std_logic lab=START}
C {sky130_fd_pr/corner.sym} 20 -630 0 0 {name=CORNER only_toplevel=true corner=tt_mm}
C {devices/lab_pin.sym} 490 -210 0 0 {name=p6 sig_type=std_logic lab=VCC}
C {devices/lab_pin.sym} 490 -190 0 0 {name=p7 lab=VSS}
C {devices/lab_pin.sym} 350 -570 0 0 {name=p1 lab=DIFFOUT_N}
C {devices/lab_pin.sym} 650 -320 0 1 {name=p10 sig_type=std_logic lab=DIFFOUT_N}
C {sky130_tests/zero_opamp.sym} 570 -320 0 0 {name=x2}
