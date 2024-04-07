-- sch_path: /mnt/c/Users/NITHIN P/tb_opamp.sch
entity tb_opamp is
end tb_opamp ;

architecture arch_tb_opamp of tb_opamp is

component not 
generic (
m : integer := 1 ;
W_N : integer := 1 ;
L_N : integer := 0.15 ;
W_P : integer := 2 ;
L_P : integer := 0.15 ;
VCCPIN : integer := VCC ;
VSSPIN : integer := VSS
);
port (
  y : out std_logic ;
  a : in std_logic
);
end component ;

component passgate 
generic (
W_N : integer := 1 ;
L_N : integer := 0.2 ;
W_P : integer := 1 ;
L_P : integer := 0.2 ;
VCCBPIN : integer := VCC ;
VSSBPIN : integer := VSS ;
m : integer := 1
);
port (
  Z : inout std_logic ;
  A : inout std_logic ;
  GP : in std_logic ;
  GN : in std_logic
);
end component ;

component opam 
port (
  DIFFOUT_N : out std_logic ;
  PLUS : in std_logic ;
  MINUS : in std_logic ;
  EN_N : in std_logic ;
  ADJ : in std_logic ;
  VCC : in std_logic ;
  VSS : in std_logic
);
end component ;


signal VCC : std_logic ;
signal VSS : std_logic ;
signal DIFFOUT_N : std_logic ;
signal EN_N : std_logic ;
signal START_N : std_logic ;
signal ADJ : std_logic ;
signal MINUS : std_logic ;
signal START : std_logic ;
signal PLUS : std_logic ;
begin
x1 : not
generic map (
   m => 1 ,
   W_N => 1 ,
   L_N => 0.15 ,
   W_P => 2 ,
   L_P => 0.15 ,
   VCCPIN => VCC ,
   VSSPIN => VSS
)
port map (
   y => START_N ,
   a => START
);

V1 : vsource
generic map (
   value => 1.8
)
port map (
   p => VCC ,
   m => VSS
);

x6 : passgate
generic map (
   W_N => 0.5 ,
   L_N => 0.15 ,
   W_P => 0.5 ,
   L_P => 0.15 ,
   VCCBPIN => VCC ,
   VSSBPIN => VSS ,
   m => 1
)
port map (
   Z => ADJ ,
   A => DIFFOUT_N ,
   GP => START ,
   GN => START_N
);

C1 : cap_mim_m3_2
generic map (
   model => cap_mim_m3_2 ,
   W => 10 ,
   L => 10 ,
   MF => 5 ,
   spiceprefix => X
)
port map (
   c0 => ADJ ,
   c1 => VSS
);

x3 : opam
port map (
   DIFFOUT_N => DIFFOUT_N ,
   PLUS => PLUS ,
   MINUS => MINUS ,
   EN_N => EN_N ,
   ADJ => ADJ ,
   VCC => VCC ,
   VSS => VSS
);

* .option SCALE=1e-6
.option method=gear

* this experimental option enables mos model bin
* selection based on W/NF instead of W
.option wnflag=1


.param VCCGAUSS = agauss(1.8, 0.05, 1)
.param VCC = VCCGAUSS
** use of following line to remove VCC variations
* .param VCC =1.8

.param TEMPGAUSS = agauss(40, 30, 1)
.option temp = TEMPGAUSS
** use of following line to remove temperature variations
* .option temp =25

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






 






  






end arch_tb_opamp ;


-- expanding   symbol:  sky130_tests/not.sym # of pins=2
-- sym_path: /home/nithinpuru/pdk/sky130A/libs.tech/xschem/sky130_tests/not.sym
-- sch_path: /home/nithinpuru/pdk/sky130A/libs.tech/xschem/sky130_tests/not.sch
entity not is
generic (
m : integer := 1 ;
W_N : integer := 1 ;
L_N : integer := 0.15 ;
W_P : integer := 2 ;
L_P : integer := 0.15 ;
VCCPIN : integer := VCC ;
VSSPIN : integer := VSS
);
port (
  y : out std_logic ;
  a : in std_logic
);
end not ;

architecture arch_not of not is


signal VCCPIN : std_logic ;
signal VSSPIN : std_logic ;
begin
M1 : nfet_01v8
generic map (
   L => L_N ,
   W => W_N ,
   nf => 1 ,
   mult => 1 ,
   model => nfet_01v8 ,
   spiceprefix => X
)
port map (
   D => y ,
   G => a ,
   S => VSSPIN ,
   B => VSSPIN
);

M2 : pfet_01v8
generic map (
   L => L_P ,
   W => W_P ,
   nf => 1 ,
   mult => 1 ,
   model => pfet_01v8 ,
   spiceprefix => X
)
port map (
   D => y ,
   G => a ,
   S => VCCPIN ,
   B => VCCPIN
);


y <= not a after 0.1 ns ;
end arch_not ;


-- expanding   symbol:  sky130_tests/passgate.sym # of pins=4
-- sym_path: /home/nithinpuru/pdk/sky130A/libs.tech/xschem/sky130_tests/passgate.sym
-- sch_path: /home/nithinpuru/pdk/sky130A/libs.tech/xschem/sky130_tests/passgate.sch
entity passgate is
generic (
W_N : integer := 1 ;
L_N : integer := 0.2 ;
W_P : integer := 1 ;
L_P : integer := 0.2 ;
VCCBPIN : integer := VCC ;
VSSBPIN : integer := VSS ;
m : integer := 1
);
port (
  Z : inout std_logic ;
  A : inout std_logic ;
  GP : in std_logic ;
  GN : in std_logic
);
end passgate ;

architecture arch_passgate of passgate is


signal VSSBPIN : std_logic ;
signal VCCBPIN : std_logic ;
begin
M1 : nfet_01v8
generic map (
   L => L_N ,
   W => W_N ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_01v8 ,
   spiceprefix => X
)
port map (
   D => Z ,
   G => GN ,
   S => A ,
   B => VSSBPIN
);

M2 : pfet_01v8
generic map (
   L => L_P ,
   W => W_P ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_01v8 ,
   spiceprefix => X
)
port map (
   D => Z ,
   G => GP ,
   S => A ,
   B => VCCBPIN
);

-- noconn VCCBPIN 
-- noconn VSSBPIN 
end arch_passgate ;


-- expanding   symbol:  /mnt/c/Users/NITHIN P/opam.sym # of pins=7
-- sym_path: /mnt/c/Users/NITHIN P/opam.sym
-- sch_path: /mnt/c/Users/NITHIN P/opam.sch
entity opam is
port (
  DIFFOUT_N : out std_logic ;
  PLUS : in std_logic ;
  MINUS : in std_logic ;
  EN_N : in std_logic ;
  ADJ : in std_logic ;
  VCC : in std_logic ;
  VSS : in std_logic
);
end opam ;

architecture arch_opam of opam is


signal G1 : std_logic ;
signal G2 : std_logic ;
signal net1 : std_logic ;
signal net2 : std_logic ;
signal net3 : std_logic ;
signal net4 : std_logic ;
signal net5 : std_logic ;
signal GND : std_logic ;
begin
M2 : pfet3_01v8
generic map (
   L => 8 ,
   W => 2 ,
   body => Vdd ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_01v8 ,
   spiceprefix => X
)
port map (
   D => net1 ,
   G => EN_N ,
   S => VCC
);

M3 : pfet_01v8_lvt
generic map (
   L => 2 ,
   W => 8 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_01v8_lvt ,
   spiceprefix => X
)
port map (
   D => G2 ,
   G => PLUS ,
   S => net1 ,
   B => VCC
);

M4 : pfet_01v8_lvt
generic map (
   L => 2 ,
   W => 8 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_01v8_lvt ,
   spiceprefix => X
)
port map (
   D => G1 ,
   G => MINUS ,
   S => net1 ,
   B => VCC
);

M1 : nfet_01v8_lvt
generic map (
   L => 4 ,
   W => 2 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_01v8_lvt ,
   spiceprefix => X
)
port map (
   D => G1 ,
   G => G1 ,
   S => VSS ,
   B => VSS
);

M5 : nfet_01v8_lvt
generic map (
   L => 4 ,
   W => 2 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_01v8_lvt ,
   spiceprefix => X
)
port map (
   D => G2 ,
   G => G2 ,
   S => VSS ,
   B => VSS
);

M6 : nfet_01v8_lvt
generic map (
   L => 4 ,
   W => 2 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_01v8_lvt ,
   spiceprefix => X
)
port map (
   D => net3 ,
   G => G1 ,
   S => VSS ,
   B => VSS
);

M7 : pfet_01v8_lvt
generic map (
   L => 4 ,
   W => 4 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_01v8_lvt ,
   spiceprefix => X
)
port map (
   D => net3 ,
   G => net3 ,
   S => net2 ,
   B => VCC
);

M8 : pfet_01v8_lvt
generic map (
   L => 4 ,
   W => 4 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_01v8_lvt ,
   spiceprefix => X
)
port map (
   D => DIFFOUT_N ,
   G => net3 ,
   S => net2 ,
   B => VCC
);

M9 : pfet3_01v8
generic map (
   L => 0.15 ,
   W => 5 ,
   body => Vdd ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_01v8 ,
   spiceprefix => X
)
port map (
   D => net2 ,
   G => EN_N ,
   S => VCC
);

M10 : nfet_01v8_lvt
generic map (
   L => 4 ,
   W => 2 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_01v8_lvt ,
   spiceprefix => X
)
port map (
   D => DIFFOUT_N ,
   G => G2 ,
   S => VSS ,
   B => VSS
);

M11 : nfet_01v8_lvt
generic map (
   L => 0.15 ,
   W => 0.5 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_01v8_lvt ,
   spiceprefix => X
)
port map (
   D => DIFFOUT_N ,
   G => EN_N ,
   S => VSS ,
   B => VSS
);

M12 : pfet_01v8
generic map (
   L => 8 ,
   W => 1 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_01v8 ,
   spiceprefix => X
)
port map (
   D => net4 ,
   G => EN_N ,
   S => VCC ,
   B => VCC
);

M14 : nfet_01v8_lvt
generic map (
   L => 1 ,
   W => 0.5 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_01v8_lvt ,
   spiceprefix => X
)
port map (
   D => G1 ,
   G => ADJ ,
   S => net5 ,
   B => VCC
);

M13 : pfet_01v8_lvt
generic map (
   L => 1 ,
   W => 1 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => pfet_01v8_lvt ,
   spiceprefix => X
)
port map (
   D => G1 ,
   G => ADJ ,
   S => net4 ,
   B => VCC
);

M15 : nfet_01v8_lvt
generic map (
   L => 8 ,
   W => 0.5 ,
   nf => 1 ,
   mult => 1 ,
   ad => 'int((nf+1)/2) * W/nf * 0.29' ,
   pd => '2*int((nf+1)/2) * (W/nf + 0.29)' ,
   as => 'int((nf+2)/2) * W/nf * 0.29' ,
   ps => '2*int((nf+2)/2) * (W/nf + 0.29)' ,
   nrd => '0.29 / W' ,
   nrs => '0.29 / W' ,
   sa => 0 ,
   sb => 0 ,
   sd => 0 ,
   model => nfet_01v8_lvt ,
   spiceprefix => X
)
port map (
   D => net5 ,
   G => VCC ,
   S => VSS ,
   B => VCC
);

end arch_opam ;

