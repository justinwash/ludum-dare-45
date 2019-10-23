#[macro_use]
extern crate gdnative as godot;

use godot::init::{Property, PropertyHint, PropertyUsage};
use godot::GodotString;

mod pathfinding;

use pathfinding::PathFinding;

fn init(handle: godot::init::InitHandle) {
    handle.add_class::<PathFinding>();
}

godot_gdnative_init!();
godot_nativescript_init!(init);
godot_gdnative_terminate!();