# Rocm-Device-Libs has moved!

This project is now located in the
[AMD Fork of the LLVM Project](https://github.com/ROCm/llvm-project),
under the "amd/device-libs" directory. This repository is now read-only.

All issues and pull requests related to the ROCm device libraries should be
filed at https://github.com/ROCm/llvm-project with the `device-libs` tag.

Users wishing to build the device libraries against upstream LLVM without
needing to clone the entire ROCm llvm-project fork can still do so as follows:

    cd <upstream-llvm-project>
    git remote add rocm-llvm https://github.com/ROCm/llvm-project.git
    git fetch rocm-llvm <branch> (default branch is amd-staging)
    git checkout rocm-llvm/<branch> -- amd (default branch is amd-staging)

The amd-specific projects, including comgr, hipcc, and device-libs, will now be
present in the `<upstream llvm-project>/amd` directory.
