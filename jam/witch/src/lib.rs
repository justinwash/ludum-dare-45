#[macro_use]
extern crate gdnative as godot;

mod pathfinding;

mod path_finding;

use self::{path_finding::RPathFinding};


fn init(handle: godot::init::InitHandle) {
    handle.add_class::<PathFinding>();
}

godot_gdnative_init!();
godot_nativescript_init!(init);
godot_gdnative_terminate!();