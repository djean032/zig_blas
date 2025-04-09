const std = @import("std");
const c = @cImport({
    @cInclude("Accelerate.h");
});

const BlasError = error {
    SizeMismatch,
    TypeMismatch,
};

pub const Complex = struct {
    re: f32,
    im: f32,
};

const ComplexDouble = struct {
    re: f64,
    im: f64,
};

// BLAS Functions that use FORTRAN calling convention
pub fn dot(comptime T: type, x: []T, y: []T, default_args: struct {
    incx: usize = 1,
    incy: usize = 1,
    conj: bool = false,

}) !T {
    const incx = default_args.incx;
    const incy = default_args.incy;
    const n = x.len;
    if (n != y.len) return BlasError.SizeMismatch;
    switch (T) {
        f32 => {
            return c.cblas_sdot(@intCast(n), x.ptr, @intCast(incx), y.ptr, @intCast(incy));
        },
        f64 => {
        return c.cblas_ddot(@intCast(n), x.ptr, @intCast(incx), y.ptr, @intCast(incy));
        },
        else => {
            return BlasError.TypeMismatch;
        }
    }
}
//void cblas_cdotu_sub(const __LAPACK_int N, const __LAPACK_float_complex * _Nullable X, const __LAPACK_int INCX,
//                    const __LAPACK_float_complex * _Nullable Y, const __LAPACK_int INCY, __LAPACK_float_complex * _Nonnull DOTU)
pub fn dot_complex(comptime T: type, x: []T, y: []T, default_args: struct {
    incx: usize = 1,
    incy: usize = 1,
    conj: bool = false,
}) !T {
    const incx = default_args.incx;
    const incy = default_args.incy;
    const n = x.len;
    var complex_return = Complex{
        .re = 0,
        .im = 0,
    };
    if (n != y.len) return BlasError.SizeMismatch;
    c.cblas_cdotu_sub(@intCast(n), x.ptr, @intCast(incx), y.ptr, @intCast(incy), @ptrCast(&complex_return));
   return complex_return; 
}

