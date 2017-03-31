# Input: amdgcn--amdhsa-amdgiz
# Output: amdgcn--amdhsa

#######################
# change target triple
#######################

# amdgcn--amdhsa-amdgiz -> amdgcn--amdhsa
/target triple/s/\"amdgcn--amdhsa-amdgiz\"/\"amdgcn--amdhsa\"/

#####################
# change data layout
#####################

# p:64:64 -> p:32:32
/target datalayout/s/-p:64:64-/-p:32:32-/

#############################
# change intrinsic functions
#############################

# change p0i32 -> p4i32
s/\.p0i32(/\.p4i32(/g

###########################
# change pointer addrspace
###########################

# change addrspace(0) -> addrspace(4)
s/addrspace(0)\*/addrspace(4)*/g
