#[macro_use]

use godot::init::{Property, PropertyHint, PropertyUsage};
use godot::GodotString;

pub struct RPathFinding {
    pathing_grid_path: godot::NodePath,
    debugging: bool,
    debug_start_path: godot::NodePath,
    debug_end_path: godot::NodePath,
    debug_aux_walkable_query_shape: godot::Shape2D,
    debug_current_node_color: godot::Color,
    debug_open_node_color: godot::Color,
    debug_unwalkable_node_color: godot::Color,

    pathing_grid_opt: Option<godot::Node>
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

            pathing_grid_opt: None
        }
    }

    #[export]
    unsafe fn _ready(&mut self, mut owner: godot::Node2D) {
        owner.set_physics_process(true);
        self.pathing_grid_opt = owner.get_node(godot::NodePath::from_str(&self.pathing_grid_path.to_string()));
    }

    #[export]
    unsafe fn _physics_process(&mut self, mut owner: godot::Node2D, delta: f64) {
        

        
    }

    #[export]
    unsafe fn find_path(&mut self, mut owner: godot::Node2D, mut start_pos: godot::Vector2, mut end_pos: godot::Vector2, mut aux_walkable_query_shape: godot::Shape2D) {

        if let Some(pathing_grid) = self.pathing_grid_opt {

            let mut pathing_grid_variant = godot::Variant::from_object(&pathing_grid);
            match pathing_grid_variant.call(
                &GodotString::from_str("node_from_world_point"), 
                &[godot::Variant::from_vector2(&start_pos)]) {
                    Ok(_) => godot_print!("i think i got the node"),
                    Err(_) => godot_print!("we didnt get the node :(")
                };
        }
        return
    }
}