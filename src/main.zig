const std = @import("std");
const blas = @import("blas.zig");

pub fn main() !void {
    var data_x = [_]f32{3.0, 1.0, 1.0};
    var data_y = [_]f32{3.0, 1.0, 1.0};
    const dp = blas.dot(f32, @intCast(3), &data_x, 1, &data_y, 1);
    std.debug.print("{d}\n", .{dp});
}
