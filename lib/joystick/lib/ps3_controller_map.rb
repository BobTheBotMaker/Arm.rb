# Based on https://github.com/hybridgroup/artoo-joystick/blob/master/lib/artoo/drivers/macosx_binding_map.rb
module JoystickController
  PS3_CONTROLLER_MAP = {
    :buttons => {
      0 => :select,
      1 => :z0,
      2 => :z1,
      3 => :start,
      4 => :up,
      5 => :right,
      6 => :down,
      7 => :left,
      8 => :left2,
      9 => :right2,
      10 => :left1,
      11 => :right1,
      12 => :triangle,
      13 => :circle,
      14 => :x,
      15 => :square,
      16 => :ps3
    },
    :joysticks => {
      :j0 => {
        :x => 0,
        :y => 1
      },
      :j1 => {
        :x => 2,
        :y => 3
      }
    }
  }
end
