require './lib/servo_controller'
require './lib/polling_servo_controller'
require './lib/joint'

sc = ServoController.new
psc = PollingServoController.new(sc)
jnt = Joint.new(psc, 0, {position_min: 30, position_max: 220, acceleration:90, ramping: true, type: :hitec_hs645mg})
jnt.move(40)
jnt.move(180)
jnt.disengage