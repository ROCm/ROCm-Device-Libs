/target triple/s/\"amdgcn--amdhsa\"/\"amdgcn--cuda\"/
/target triple/s/\"amdgcn--amdhsa-amdgiz\"/\"amdgcn--cuda\"/

# undo the -A5 changes made by add_giz
/target datalayout/s/-n32:64-A5/-n32:64/
# undo the -p4 width  change made by add_giz
# our llvm still uses p4 contant
/target datalayout/s/-p4:32:32-/-p4:64:64-/
