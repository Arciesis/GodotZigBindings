const std = @import("std");

pub inline fn BaseType(comptime T: type) type {
    const type_info = @typeInfo(T);
    const type_tag = @typeInfo(std.builtin.Type).@"union".tag_type.?;
    switch (type_info) {
        type_tag.pointer => {
            return type_info.pointer.child;
        },
        type_tag.optional => {
            return BaseType(type_info.optional.child);
        },
        else => {
            return T;
        },
    }
}

pub inline fn isPointerType(comptime T: type) bool {
    const type_info = @typeInfo(T);
    const type_tag = @typeInfo(std.builtin.Type).@"union".tag_type.?;
    switch (type_info) {
        type_tag.pointer => {
            return true;
        },
        type_tag.optional => {
            return isPointerType(type_info.optional.child);
        },
        else => {
            return false;
        },
    }
}

pub inline fn isTypeGodotObjectClass(comptime T: type) bool {
    const type_info = @typeInfo(T);
    const type_tag = @typeInfo(std.builtin.Type).@"union".tag_type.?;
    switch (type_info) {
        type_tag.@"struct" => {
            return @hasDecl(T, "GodotClass");
        },
        type_tag.pointer => {
            return isTypeGodotObjectClass(type_info.pointer.child);
        },
        type_tag.optional => {
            return isTypeGodotObjectClass(type_info.optional.child);
        },
        else => {
            return false;
        },
    }
}
