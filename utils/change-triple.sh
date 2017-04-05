#!/bin/sh

# Usage:
# utils/change-triple.sh   : apply utils/add_amdgiz.sed
#                                adopt generic address space is address space 0
# utils/change-triple.sh x : apply utils/remove_amdgiz.sed
#                                adopt generic address space is address space 4

if [ $# -lt 1 ]; then
  find . -name "*.ll" | xargs sed -i -f "utils/add_cuda.sed"
else
  find . -name "*.ll" | xargs sed -i -f "utils/remove_cuda.sed"
fi

