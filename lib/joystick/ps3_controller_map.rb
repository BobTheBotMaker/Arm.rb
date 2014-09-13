# Based on https://github.com/hybridgroup/artoo-joystick/blob/master/lib/artoo/drivers/macosx_binding_map.rb
PS3_CONTROLLER_MAP = {
  :buttons => {
    0 => :select,
    1 => :j0,
    2 => :j1,
    3 => :start,
    4 => :dpad_up,
    5 => :dpad_right,
    6 => :dpad_down,
    7 => :dpad_left,
    8 => :l2,
    9 => :r2,
    10 => :l1,
    11 => :r1,
    12 => :triangle,
    13 => :circle,
    14 => :x,
    15 => :square,
    16 => :ps3
  },
  :joysticks => {
    0 => {
      0 => :x,
      1 => :y
    },
    1 => {
      2 => :x,
      3 => :y
    }
  }
}