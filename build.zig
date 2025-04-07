const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});
    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "zig_blas",
        .root_module = exe_mod,
    });

    exe.addIncludePath(b.path("src"));
    exe.addIncludePath(b.path("../../source/OpenBLAS-0.3.29_x86/include/"));
    exe.addLibraryPath(b.path("../../source/OpenBLAS-0.3.29_x86/lib/"));

    exe.linkLibC();
    exe.linkSystemLibrary("openblas");

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
