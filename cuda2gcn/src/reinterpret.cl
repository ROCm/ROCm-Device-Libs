/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#define ATTR __attribute__((always_inline const))

//-------- T __nv_double_as_longlong
ATTR long __nv_double_as_longlong(double x)
{
  return as_long(x);
}

//-------- T __nv_float_as_int
ATTR int __nv_float_as_int(float x)
{
  return as_int(x);
}

//-------- T __nv_float_as_uint
ATTR unsigned int __nv_float_as_uint(float x)
{
  return as_uint(x);
}

//-------- T __nv_int_as_float
ATTR float __nv_int_as_float(int x)
{
  return as_float(x);
}

//-------- T __nv_longlong_as_double
ATTR double __nv_longlong_as_double(long x)
{
  return as_double(x);
}

//-------- T __nv_uint_as_float
ATTR float __nv_uint_as_float(unsigned int x)
{
  return as_float(x);
}

