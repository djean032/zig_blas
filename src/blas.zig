const std = @import("std");
const c = @cImport({
    @cInclude("./include/cblas.h");
});

const BlasError = error{
    SizeMismatch,
    TypeMismatch,
};

fn ComplexReturn(comptime T: type, c_ret: struct { re: T, im: T }) std.math.complex.Complex(T) {
    return std.math.complex.Complex(T).init(c_ret.re, c_ret.im);
}

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
        std.math.Complex(f32) => {
            if (default_args.conj == false) {
        return c.cblas_cdotu(@intCast(n), x.ptr, @intCast(incx), y.ptr, @intCast(incy));
            } else if (default_args.conj == true) {
        return c.cblas_cdotc(@intCast(n), x.ptr, @intCast(incx), y.ptr, @intCast(incy));
            }
        },
        std.math.Complex(f64) => {
            if (default_args.conj == false) {
        return c.cblas_zdotu(@intCast(n), x.ptr, @intCast(incx), y.ptr, @intCast(incy));
            } else if (default_args.conj == true) {
        return c.cblas_zdotc(@intCast(n), x.ptr, @intCast(incx), y.ptr, @intCast(incy));
            }
        },
        else => {
            return BlasError.TypeMismatch;
        }
    }
}
