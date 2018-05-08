//===----------------------------------------------------------------------===//
//   assertfail.cl: amdgcn device routine for assertfail
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.txt for details.
//
//===----------------------------------------------------------------------===//


#define ATTR __attribute__((always_inline))

extern ATTR void __device_trap();

ATTR void __assertfail(const char * __assertion,
        const char *__file,
        unsigned int __line,
        const char *__function,
        size_t charsize)
{
    // ignore all the args for now.
    __device_trap();
}

