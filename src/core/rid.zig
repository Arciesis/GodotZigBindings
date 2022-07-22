const gd = @import("api.zig");
const c = gd.c;

const Object = @import("../gen/object.zig").Object;

pub const RID = struct {

    godot_rid: c.godot_rid,

    const Self = @This();

    pub fn new() Self {
        var self = Self {
            .godot_rid = undefined,
        };

        gd.api.*.godot_rid_new.?(&self.godot_rid);

        return self;
    }

    pub fn newObject(object: *const Object) Self {
        var self = Self {
            .godot_rid = undefined,
        };

        gd.api.*.godot_rid_new_with_resource.?(&self.godot_rid, @ptrCast([*c]c.godot_object, object.base.owner));

        return self;
    }

    pub fn getId(self: *const Self) i32 {
        return gd.api.*.godot_rid_get_id.?(&self.godot_rid);
    }

    pub fn equal(self: *const Self, other: *const RID) bool { // Operator ==
        return gd.api.*.godot_rid_operator_equal.?(&self.godot_rid, &other.godot_rid);
    }

    pub fn notEqual(self: *const Self, other: *const RID) bool { // Operator !=
        return !equal(self, other);
    }

    pub fn less(self: *const Self, other: *const RID) bool { // Operator <
        return gd.api.*.godot_rid_operator_less.?(&self.godot_rid, &other.godot_rid);
    }

    pub fn lessEqual(self: *const Self, other: *const RID) bool { // Operator <=
        return less(self, other) || equal(self, other);
    }

    pub fn more(self: *const Self, other: *const RID) bool { // Operator >
        return !lessEqual(self, other);
    }

    pub fn moreEqual(self: *const Self, other: *const RID) bool { // Operator >=
        return !less(self, other);
    }

};
