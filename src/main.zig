const std = @import("std");
const blas = @import("blas.zig");

pub fn main() !void {
    const comp_val = std.math.complex.Complex(f32).init(1,1);
    var data_x = [_]std.math.complex.Complex(f32){comp_val, comp_val};
    var data_y = [_]std.math.complex.Complex(f32){comp_val, comp_val};
    const dp = try blas.dot(std.math.complex.Complex(f32), &data_x, &data_y, .{});
    std.debug.print("{d}\n", .{dp});
}
