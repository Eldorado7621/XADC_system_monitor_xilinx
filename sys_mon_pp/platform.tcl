# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/sam/git_workspace/fft_project/fft_sw/sys_mon_pp/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/sam/git_workspace/fft_project/fft_sw/sys_mon_pp/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {sys_mon_pp}\
-hw {/home/sam/git_workspace/fft_project/temp_system_monitor/design_1_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -out {/home/sam/git_workspace/fft_project/fft_sw}

platform write
platform generate -domains 
platform active {sys_mon_pp}
platform generate
bsp reload
bsp setlib -name xilffs -ver 4.6
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains standalone_domain 
