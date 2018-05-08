//===----------------------------------------------------------------------===//
// hipdrt_printf_alloc.cl: device runtime routine for allocating print buffer
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.txt for details.
//
//===----------------------------------------------------------------------===//

#include "hip/hip_runtime.h"

//  ====================================================
//  ----  FIXME:  Create a hip header file out of this -------
#define HIP_VERSION 0
#define HIP_RELEASE 0
#define HIP_PATCH   0
#define HIP_VRM ((HIP_VERSION*65536) + (HIP_RELEASE*256) + HIP_PATCH)
#define HIP_ID ((HIP_VERSION*256) + HIP_RELEASE)

typedef short hip_id_t;
typedef short hip_service_id_t;

enum hip_Services{
  HIP_SERVICE_PRINTF,
};

struct hip_service_header{
  unsigned         size;           // total size of service buffer
  hip_service_id_t service_id;     // 2 byte service_id
  hip_id_t         device_hip_id;  // 2 byte hip version and release id
};
typedef struct hip_service_header hip_service_header_t; // size 

struct buffer_header_s{
  unsigned size;
  unsigned total;
};
typedef struct buffer_header_s buffer_header_t;


#ifndef NULL
#define NULL 0
#endif

//  ----  End  Create a header file out of this -------
//  ====================================================

#define INLINE extern "C" __attribute__((always_inline,const)) __device__
#define OFFSET 8

// We communicate the pointer to the service buffer with this global variable
extern __device__ long *hip_service_buffer;

// hipdrt_alloc_service_buffer:  Allocate device global memory hipdrt_alloc_service_buffer
INLINE char * hipdrt_alloc_service_buffer(uint bufsz) {
    char *ptr = (char *) *hip_service_buffer;
    uint size = ((uint *)ptr)[1];
    uint offset = atomicAdd((unsigned int *)ptr, 0);
    for (;;) {
        if (OFFSET + offset + bufsz > size) return NULL;
        if (atomicCAS((unsigned int *)ptr, offset, offset+bufsz))
            break;
    }
    return ptr + OFFSET + offset;
}

// gen2dev_memcpy:  Generic to global memcpy for character string
INLINE void gen2dev_memcpy(char*dst, char*src, uint len) {
    for (int i=0 ; i< len ; i++) dst[i]=src[i];
}

// hipdrt_printf_alloc: allocate device mem, create header, 
// copy fmtstr, return generic data ptr
INLINE char* hipdrt_printf_alloc(char*fmtstr, uint fmtlen, uint datalen) {
    // Allocate device global memory
    size_t headsize = sizeof(hip_service_header_t);
    uint buffsize   = (uint) headsize + fmtlen + datalen ;
    char* buffer = hipdrt_alloc_service_buffer(buffsize);
    if (buffer) {
        hip_service_header_t* header = (hip_service_header_t*) buffer;
        header->size           = buffsize;
        header->service_id     = (hip_service_id_t) HIP_SERVICE_PRINTF;
        header->device_hip_id = (hip_id_t) HIP_ID ;
        gen2dev_memcpy((char*) (buffer+headsize), fmtstr, fmtlen);
        return (buffer + headsize + (size_t)fmtlen);
    } else 
        return NULL;
}
