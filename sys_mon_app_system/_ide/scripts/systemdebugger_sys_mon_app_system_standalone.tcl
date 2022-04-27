# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: /home/sam/git_workspace/fft_project/fft_sw/sys_mon_app_system/_ide/scripts/systemdebugger_sys_mon_app_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source /home/sam/git_workspace/fft_project/fft_sw/sys_mon_app_system/_ide/scripts/systemdebugger_sys_mon_app_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zybo Z7 210351A8231FA" && level==0 && jtag_device_ctx=="jsn-Zybo Z7-210351A8231FA-23727093-0"}
fpga -file /home/sam/git_workspace/fft_project/fft_sw/sys_mon_app/_ide/bitstream/design_1_wrapper.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw /home/sam/git_workspace/fft_project/fft_sw/sys_mon_pp/export/sys_mon_pp/hw/design_1_wrapper.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source /home/sam/git_workspace/fft_project/fft_sw/sys_mon_app/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow /home/sam/git_workspace/fft_project/fft_sw/sys_mon_app/Debug/sys_mon_app.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "*A9*#0"}
con
