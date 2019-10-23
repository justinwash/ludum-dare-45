#[macro_use]
extern crate gdnative as godot;

use godot::init::{Property, PropertyHint, PropertyUsage};
use godot::GodotString;

mod path_finding;

use self::{path_finding::RPathFinding};



fn init(handle: godot::init::InitHandle) {
    handle.add_class::<RPathFinding>();
}

godot_gdnative_init!();
godot_nativescript_init!(init);
godot_gdnative_terminate!();