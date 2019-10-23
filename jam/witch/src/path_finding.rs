#[macro_use]

use godot::init::{Property, PropertyHint, PropertyUsage};
use godot::GodotString;

use std::collections::HashSet;

pub struct RPathFinding {
    pathing_grid_path: godot::NodePath,
    debugging: bool,
    debug_start_path: godot::NodePath,
    debug_end_path: godot::NodePath,
    debug_aux_walkable_query_shape: godot::Shape2D,
    debug_current_node_color: godot::Color,
    debug_open_node_color: godot::Color,
    debug_unwalkable_node_color: godot::Color,
}

unsafe impl Send for RPathFinding {}

impl godot::NativeClass for RPathFinding {
    type Base = godot::Node2D;
    type UserData = godot::user_data::MutexData<RPathFinding>;

    fn class_name() -> &'static str {
        "RPathFinding"
    }

    fn init(_owner: Self::Base) -> Self {
        Self::_init()
    }

    fn register_properties(builder: &godot::init::ClassBuilder<Self>) {
        builder.add_property(Property {
            name: "pathing_grid_path",
            default: godot::NodePath::from_str(""),
            hint: PropertyHint::NodePathToEditedNode,
            getter: |this: &RPathFinding| godot::NodePath::from_str(&this.pathing_grid_path.to_string()),
            setter: |this: &mut RPathFinding, v| this.pathing_grid_path = v,
            usage: PropertyUsage::DEFAULT,
        });

        builder.add_property(Property {
            name: "debugging/is_debugging",
            default: false,
            hint: PropertyHint::None,
            getter: |this: &RPathFinding| this.debugging,
            setter: |this: &mut RPathFinding, v| this.debugging = v,
            usage: PropertyUsage::DEFAULT,
        });

        builder.add_property(Property {
            name: "debugging/debug_start_path",
            default: godot::NodePath::from_str(""),
            hint: PropertyHint::NodePathToEditedNode,
            getter: |this: &RPathFinding| godot::NodePath::from_str(&this.debug_start_path.to_string()),
            setter: |this: &mut RPathFinding, v| this.debug_start_path = v,
            usage: PropertyUsage::DEFAULT,
        });

        builder.add_property(Property {
            name: "debugging/debug_end_path",
            default: godot::NodePath::from_str(""),
            hint: PropertyHint::NodePathToEditedNode,
            getter: |this: &RPathFinding| godot::NodePath::from_str(&this.debug_end_path.to_string()),
            setter: |this: &mut RPathFinding, v| this.debug_end_path = v,
            usage: PropertyUsage::DEFAULT,
        });

        builder.add_property(Property {
            name: "debugging/aux_walkable_query_shape",
            default: godot::Shape2D { this: std::ptr::null_mut() },
            hint: PropertyHint::None,
            getter: |this: &RPathFinding| this.debug_aux_walkable_query_shape.clone(),
            setter: |this: &mut RPathFinding, v| this.debug_aux_walkable_query_shape = v,
            usage: PropertyUsage::DEFAULT,
        });

        builder.add_property(Property {
            name: "debugging/current_node_color",
            default: godot::Color::rgb(0.0, 0.0, 0.0),
            hint: PropertyHint::None,
            getter: |this: &RPathFinding| this.debug_current_node_color,
            setter: |this: &mut RPathFinding, v| this.debug_current_node_color = v,
            usage: PropertyUsage::DEFAULT,
        });

        builder.add_property(Property {
            name: "debugging/open_node_color",
            default: godot::Color { r:0.0, g:0.0, b:0.0, a:1.0 },
            hint: PropertyHint::None,
            getter: |this: &RPathFinding| this.debug_open_node_color,
            setter: |this: &mut RPathFinding, v| this.debug_open_node_color = v,
            usage: PropertyUsage::DEFAULT,
        });

        builder.add_property(Property {
            name: "debugging/unwalkable_node_color",
            default: godot::Color { r:0.0, g:0.0, b:0.0, a:1.0 },
            hint: PropertyHint::None,
            getter: |this: &RPathFinding| this.debug_unwalkable_node_color,
            setter: |this: &mut RPathFinding, v| this.debug_unwalkable_node_color = v,
            usage: PropertyUsage::DEFAULT,
        });
    }

}

#[godot::methods]
impl RPathFinding {
    fn _init() -> Self {
        RPathFinding {
            pathing_grid_path: godot::NodePath::from_str(""),
            debugging: false,
            debug_start_path: godot::NodePath::from_str(""),
            debug_end_path: godot::NodePath::from_str(""),
            debug_aux_walkable_query_shape: godot::Shape2D { this: std::ptr::null_mut() },
            debug_current_node_color: godot::Color::rgb(0.0, 0.0, 0.0),
            debug_open_node_color: godot::Color::rgb(0.0, 0.0, 0.0),
            debug_unwalkable_node_color: godot::Color::rgb(0.0, 0.0, 0.0),
        }
    }

    #[export]
    unsafe fn _ready(&mut self, mut owner: godot::Node2D) {
        owner.set_physics_process(true);
    }

    #[export]
    unsafe fn _physics_process(&mut self, mut owner: godot::Node2D, delta: f64) {
        

        
    }

    #[export]
    unsafe fn find_path(&mut self, mut owner: godot::Node2D, mut start_pos: godot::Vector2, mut end_pos: godot::Vector2, mut aux_walkable_query_shape: godot::Shape2D) {

        let pathing_grid_opt = owner.get_node(godot::NodePath::from_str(&self.pathing_grid_path.to_string()));
        if let Some(pathing_grid) = pathing_grid_opt {

            let mut pathing_grid_variant = godot::Variant::from_object(&pathing_grid);

            let mut start = godot::Variant::new();
            let mut end = godot::Variant::new();

            match pathing_grid_variant.call(
                &GodotString::from_str("node_from_world_point"), 
                &[godot::Variant::from_vector2(&start_pos)]) {
                    Ok(v) => { start = v; godot_print!("think i got it") },
                    Err(_) => godot_print!("we didnt get the node :(")
                };

            match pathing_grid_variant.call(
                &GodotString::from_str("node_from_world_point"), 
                &[godot::Variant::from_vector2(&start_pos)]) {
                    Ok(v) => { end = v; godot_print!("think i got it") },
                    Err(_) => godot_print!("we didnt get the node :(")
                };

            let mut open: &mut Vec<godot::Variant> = &mut Vec::new();
            let mut closed: &mut Vec<godot::Variant> = &mut Vec::new();

            open.push(start);

            
            while !open.is_empty() {
                let mut current_node: godot::Variant = open[0].clone();

                for i in 1..open.len() {
                    let mut open_f_cost = 0;
                    let mut current_f_cost = 0;
                    let mut open_h_cost = 0;
                    let mut current_h_cost = 0;

                    let mut current_open: godot::Variant = open[i].clone();

                    match (&mut current_open).call(&GodotString::from_str("get_f_cost"), &[]) {
                        Ok(v) => open_f_cost = v.to_i64(),
                        Err(_) => godot_print!("error getting open f cost")
                    };

                    match current_node.call(&GodotString::from_str("get_f_cost"), &[]) {
                        Ok(v) => current_f_cost = v.to_i64(),
                        Err(_) => godot_print!("error getting current f cost")
                    };

                    match current_open.call(&GodotString::from_str("get_h_cost"), &[]) {
                        Ok(v) => open_h_cost = v.to_i64(),
                        Err(_) => godot_print!("error getting open h cost")
                    };

                    match current_node.call(&GodotString::from_str("get_h_cost"), &[]) {
                        Ok(v) => current_h_cost = v.to_i64(),
                        Err(_) => godot_print!("error getting current h cost")
                    };

                    godot_print!("open_f: {} | current_f: {} | open_h: {} | current_h: {}", open_f_cost, current_f_cost, open_h_cost, current_h_cost);

                    if (open_f_cost < current_f_cost) || (open_f_cost == current_f_cost && open_h_cost < current_h_cost) {
                        current_node = current_open;
                    }
                }

                open.retain(|x| &current_node != x);
                closed.push(current_node);

                if closed[closed.len()] == end { // this is sorta dumb but it should work i guess. fuck ownership.
                    return //get_node_path(start, end);
                }

                let mut neighbors = godot::VariantArray::new();
                match pathing_grid_variant.call(
                &GodotString::from_str("get_neighbors"), 
                &[godot::Variant::from_variant(&current_node)]) {
                    Ok(v) => { end = v; godot_print!("think i got it") },
                    Err(_) => godot_print!("we didnt get the node :(")
                };
            }


        }
        return
    }
}