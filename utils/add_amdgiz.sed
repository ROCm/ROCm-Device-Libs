# Input: amdgcn--amdhsa
# Output: amdgcn--amdhsa-amdgiz

#######################
# change target triple
#######################

# amdgcn--amdhsa-amd -> amdgcn--amdhsa-amdgiz
# This is now done directly by change-addr-space.sh
# /target triple/s/\"amdgcn--amdhsa\"/\"amdgcn--amdhsa-amdgiz\"/

#####################
# change data layout
#####################

# cleanup datalayouts to latest in upstream AMDGPU.cpp
/target datalayout/s/-p:32:32-/-p:64:64-/
/target datalayout/s/-p2:64:64-/-p2:32:32-/
/target datalayout/s/-p4:32:32-/-p4:64:64-/
/target datalayout/s/-p5:32:32-i64/-p5:32:32-p6:32:32-i64/
/target datalayout/s/-n32:64/-n32:64-A5/

#############################
# change intrinsic functions
#############################

# change p4i32 -> p0i32
s/\.p4i32(/\.p0i32(/g

###########################
# change pointer addrspace
###########################

# change addrspace(0) -> addrspace(5)
s/addrspace(0)\*/addrspace(5)*/g

# change addrspace(4) -> addrspace(0)
s/addrspace(4)\*/addrspace(0)*/g
