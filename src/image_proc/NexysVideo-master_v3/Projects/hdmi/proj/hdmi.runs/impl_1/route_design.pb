
Q
Command: %s
53*	vivadotcl2 
route_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a200t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a200t2default:defaultZ17-349h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
V

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px� 
y
BMultithreading enabled for route_design using a maximum of %s CPUs97*route2
22default:defaultZ35-254h px� 
p

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px� 
B
-Phase 1 Build RT Design | Checksum: e9cd2f9e
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:36 ; elapsed = 00:01:13 . Memory (MB): peak = 2129.332 ; gain = 0.0002default:defaulth px� 
v

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px� 
o

Phase %s%s
101*constraints2
2.1 2default:default2 
Create Timer2default:defaultZ18-101h px� 
A
,Phase 2.1 Create Timer | Checksum: e9cd2f9e
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:38 ; elapsed = 00:01:15 . Memory (MB): peak = 2129.332 ; gain = 0.0002default:defaulth px� 
{

Phase %s%s
101*constraints2
2.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px� 
M
8Phase 2.2 Fix Topology Constraints | Checksum: e9cd2f9e
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:39 ; elapsed = 00:01:16 . Memory (MB): peak = 2129.332 ; gain = 0.0002default:defaulth px� 
t

Phase %s%s
101*constraints2
2.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px� 
F
1Phase 2.3 Pre Route Cleanup | Checksum: e9cd2f9e
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:01:39 ; elapsed = 00:01:16 . Memory (MB): peak = 2129.332 ; gain = 0.0002default:defaulth px� 
p

Phase %s%s
101*constraints2
2.4 2default:default2!
Update Timing2default:defaultZ18-101h px� 
C
.Phase 2.4 Update Timing | Checksum: 2268395a4
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:02:44 ; elapsed = 00:01:54 . Memory (MB): peak = 2129.332 ; gain = 0.0002default:defaulth px� 
�
Intermediate Timing Summary %s164*route2N
:| WNS=-5.011 | TNS=-5751.806| WHS=-0.673 | THS=-3499.522|
2default:defaultZ35-416h px� 
I
4Phase 2 Router Initialization | Checksum: 223b2d1eb
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:03:26 ; elapsed = 00:02:18 . Memory (MB): peak = 2129.332 ; gain = 0.0002default:defaulth px� 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px� 
C
.Phase 3 Initial Routing | Checksum: 19286f9b5
*commonh px� 
�

%s
*constraints2o
[Time (s): cpu = 00:05:06 ; elapsed = 00:03:09 . Memory (MB): peak = 2129.332 ; gain = 0.0002default:defaulth px� 
s

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px� 
u

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
4.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
E
0Phase 4.1.1 Update Timing | Checksum: 10bfadb1c
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:09:49 ; elapsed = 00:06:47 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
�
Intermediate Timing Summary %s164*route2L
8| WNS=-5.940 | TNS=-8283.205| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
v

Phase %s%s
101*constraints2
4.1.2 2default:default2%
GlobIterForTiming2default:defaultZ18-101h px� 
t

Phase %s%s
101*constraints2
4.1.2.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
G
2Phase 4.1.2.1 Update Timing | Checksum: 19cf4a9a8
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:09:54 ; elapsed = 00:06:50 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
u

Phase %s%s
101*constraints2
4.1.2.2 2default:default2"
Fast Budgeting2default:defaultZ18-101h px� 
G
2Phase 4.1.2.2 Fast Budgeting | Checksum: f1b3bc0f
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:09:59 ; elapsed = 00:06:56 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
I
4Phase 4.1.2 GlobIterForTiming | Checksum: 195bae4a0
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:10:01 ; elapsed = 00:06:57 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
H
3Phase 4.1 Global Iteration 0 | Checksum: 195bae4a0
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:10:01 ; elapsed = 00:06:57 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
u

Phase %s%s
101*constraints2
4.2 2default:default2&
Global Iteration 12default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
4.2.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
D
/Phase 4.2.1 Update Timing | Checksum: d5b205b8
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:10:14 ; elapsed = 00:07:08 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
�
Intermediate Timing Summary %s164*route2L
8| WNS=-5.947 | TNS=-8167.297| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
H
3Phase 4.2 Global Iteration 1 | Checksum: 25f5f9c4c
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:10:15 ; elapsed = 00:07:08 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
F
1Phase 4 Rip-up And Reroute | Checksum: 25f5f9c4c
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:10:15 ; elapsed = 00:07:08 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
|

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
5.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
5.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
E
0Phase 5.1.1 Update Timing | Checksum: 1d927c309
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:10:30 ; elapsed = 00:07:16 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
�
Intermediate Timing Summary %s164*route2L
8| WNS=-5.940 | TNS=-8234.338| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
C
.Phase 5.1 Delay CleanUp | Checksum: 16d349f3b
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:10:58 ; elapsed = 00:07:31 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px� 
M
8Phase 5.2 Clock Skew Optimization | Checksum: 16d349f3b
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:10:58 ; elapsed = 00:07:32 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
O
:Phase 5 Delay and Skew Optimization | Checksum: 16d349f3b
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:10:59 ; elapsed = 00:07:32 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
n

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
6.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
6.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
E
0Phase 6.1.1 Update Timing | Checksum: 15455e56b
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:11:21 ; elapsed = 00:07:44 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
�
Intermediate Timing Summary %s164*route2L
8| WNS=-5.736 | TNS=-7851.900| WHS=0.002  | THS=0.000  |
2default:defaultZ35-416h px� 
C
.Phase 6.1 Hold Fix Iter | Checksum: 203041371
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:11:21 ; elapsed = 00:07:45 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
�
�The router encountered %s pins that are both setup-critical and hold-critical and tried to fix hold violations at the expense of setup slack. Such pins are:
%s201*route2
5852default:default2�
�	hdmi_i/ila_0/U0/ila_core_inst/shifted_data_in_reg[7][450]_srl8/D
	hdmi_i/ila_0/U0/ila_core_inst/shifted_data_in_reg[7][451]_srl8/D
	hdmi_i/ila_0/U0/ila_core_inst/shifted_data_in_reg[7][424]_srl8/D
	hdmi_i/ila_0/U0/ila_core_inst/shifted_data_in_reg[7][422]_srl8/D
	hdmi_i/ila_0/U0/ila_core_inst/shifted_data_in_reg[7][420]_srl8/D
	hdmi_i/ila_0/U0/ila_core_inst/shifted_data_in_reg[7][418]_srl8/D
	hdmi_i/ila_0/U0/ila_core_inst/shifted_data_in_reg[7][461]_srl8/D
	hdmi_i/ila_0/U0/ila_core_inst/shifted_data_in_reg[7][462]_srl8/D
	hdmi_i/ila_0/U0/ila_core_inst/shifted_data_in_reg[7][463]_srl8/D
	hdmi_i/ila_0/U0/ila_core_inst/shifted_data_in_reg[7][464]_srl8/D
	.. and 575 more pins.
2default:defaultZ35-468h px� 
A
,Phase 6 Post Hold Fix | Checksum: 203041371
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:11:22 ; elapsed = 00:07:45 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
o

Phase %s%s
101*constraints2
7 2default:default2"
Route finalize2default:defaultZ18-101h px� 
B
-Phase 7 Route finalize | Checksum: 1e40c9f2d
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:11:22 ; elapsed = 00:07:45 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
v

Phase %s%s
101*constraints2
8 2default:default2)
Verifying routed nets2default:defaultZ18-101h px� 
I
4Phase 8 Verifying routed nets | Checksum: 1e40c9f2d
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:11:23 ; elapsed = 00:07:46 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
r

Phase %s%s
101*constraints2
9 2default:default2%
Depositing Routes2default:defaultZ18-101h px� 
E
0Phase 9 Depositing Routes | Checksum: 15a7c3227
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:11:29 ; elapsed = 00:07:52 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
t

Phase %s%s
101*constraints2
10 2default:default2&
Post Router Timing2default:defaultZ18-101h px� 
�
Estimated Timing Summary %s
57*route2L
8| WNS=-5.736 | TNS=-7851.900| WHS=0.002  | THS=0.000  |
2default:defaultZ35-57h px� 
B
!Router estimated timing not met.
128*routeZ35-328h px� 
G
2Phase 10 Post Router Timing | Checksum: 15a7c3227
*commonh px� 
�

%s
*constraints2p
\Time (s): cpu = 00:11:29 ; elapsed = 00:07:52 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
=
Router Completed Successfully
16*routeZ35-16h px� 
�

%s
*constraints2p
\Time (s): cpu = 00:11:29 ; elapsed = 00:07:52 . Memory (MB): peak = 2172.617 ; gain = 43.2852default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
672default:default2
1072default:default2
72default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
route_design: 2default:default2
00:11:382default:default2
00:07:582default:default2
2172.6172default:default2
43.2852default:defaultZ17-268h px� 
D
Writing placer database...
1603*designutilsZ20-1893h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:352default:default2
00:00:122default:default2
2172.6172default:default2
0.0002default:defaultZ17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:402default:default2
00:00:172default:default2
2172.6172default:default2
0.0002default:defaultZ17-268h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
�
#The results of DRC are in file %s.
168*coretcl2�
rD:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.runs/impl_1/hdmi_wrapper_drc_routed.rptrD:/Xilinx/Projects/image_proc/NexysVideo-master_v3/Projects/hdmi/proj/hdmi.runs/impl_1/hdmi_wrapper_drc_routed.rpt2default:default8Z2-168h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
report_drc: 2default:default2
00:00:232default:default2
00:00:142default:default2
2172.6172default:default2
0.0002default:defaultZ17-268h px� 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px� 
�
>Generated clock %s has no logical paths from master clock %s.
174*timing21
hdmi_i/rgb2dvi_0/U0/SerialClk2default:default2*
axi_dynclk_0_PXL_CLK_O2default:defaultZ38-249h px� 
�
rThe design failed to meet the timing requirements. Please see the %s report for details on the timing violations.
188*timing2"
timing summary2default:defaultZ38-282h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2+
report_timing_summary: 2default:default2
00:01:212default:default2
00:00:442default:default2
2269.7192default:default2
97.1022default:defaultZ17-268h px� 
�
>Generated clock %s has no logical paths from master clock %s.
174*timing21
hdmi_i/rgb2dvi_0/U0/SerialClk2default:default2*
axi_dynclk_0_PXL_CLK_O2default:defaultZ38-249h px� 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px� 
�
>Generated clock %s has no logical paths from master clock %s.
174*timing21
hdmi_i/rgb2dvi_0/U0/SerialClk2default:default2*
axi_dynclk_0_PXL_CLK_O2default:defaultZ38-249h px� 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px� 
�
�Detected over-assertion of set/reset/preset/clear net with high fanouts, power estimation might not be accurate. Please run Tool - Power Constraint Wizard to set proper switching activities for control signals.282*powerZ33-332h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
report_power: 2default:default2
00:00:262default:default2
00:00:142default:default2
2296.4612default:default2
26.7422default:defaultZ17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
report_clock_utilization: 2default:default2
00:00:072default:default2
00:00:082default:default2
2296.4612default:default2
0.0002default:defaultZ17-268h px� 


End Record