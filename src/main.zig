const std = @import("std");
const blas = @import("blas.zig");

pub fn main() !void {
    var data_x = [_]blas.Complex{ 
        .{.re = 1.0, .im = 1.0}, 
        .{.re = 1.0, .im = 1.0}, 
        .{.re = 1.0, .im = 1.0}, 
    };
    var data_y = [_]blas.Complex{ 
        .{.re = 1.0, .im = 1.0}, 
        .{.re = 1.0, .im = 1.0}, 
        .{.re = 1.0, .im = 1.0}, 
    };
    const dp = try blas.dot_complex(blas.Complex, &data_x, &data_y, .{});
    std.debug.print("{any}\n", .{dp});
}
