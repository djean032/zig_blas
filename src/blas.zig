const std = @import("std");
const c = @cImport({
    @cInclude("cblas.h");
});



pub fn dot(
    comptime T: type,
    x: [*]T,
    y: [*]T,
    default_args: struct {
        incx: usize = 1,
        incy: usize = 1,
    }) ?T {
    n = x.len;
    if (n != y.len) return
    if (T == f32) {
        return c.cblas_sdot(@intCast(n), x, @intCast(incx), y, @intCast(incy));
    } else if (T == f64) {
        return c.cblas_ddot(n, x, incx, y, incy);
    } 
}
