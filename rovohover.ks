//
//


// target climbrate
set target_cr to 0.

// target groundspeed, horizontal velocity forward
set target_gr to 0.


//lock steering to up.
//set head to -SHIP:BEARING.
//set head to 180.
//set steer to HEADING(head, 90).
//lock STEERING to steer.
//set steer to SHIP:FACING.
//lock steering to steer.


// pid for throttle
set kp to 0.1.
set ki to 0.01.
set kd to 0.01.

set pid to PIDLOOP(kp, ki, kd).
set pid:SETPOINT to 0.

set t to 0.7.
set output to t.
lock throttle to t.


// pid for horizontal velocity
set ip to 0.1.
set ii to 0.01.
set id to 0.01.

set hpid to PIDLOOP(ip, ii, id).
set hpid:SETPOINT to 0.

set s_rot to SHIP:FACING + R(0, 0, 0).
set o to 0.
//lock steering to s_rot.
//lock steering to up.
//SET STEERINGMANAGER:PITCHPID:KD TO 1.
//SET STEERINGMANAGER:YAWPID:KD to 1.
//LOCK STEERING TO VXCL(SHIP:UP:VECTOR,-SHIP:VELOCITY:SURFACE).
lock steering to up.

// inputs
on AG1 {
  set target_cr to target_cr - 1.
  print target_cr.
  preserve.
}

on AG4 {
  set target_cr to target_cr + 1.
  print target_cr.
  preserve.
}

set ap_running to true.
//on TIME:SECONDS {
until false {
  // throttle pid loop
  set current_cr to SHIP:VERTICALSPEED.
  set d to current_cr - target_cr.

  set output to output + pid:UPDATE(TIME:SECONDS, d).
  //print output.
  //set pitch_angle to MAX(MIN(output, _pitch_angle_max), -_pitch_angle_max).
  //PRINT pitch_angle.
  //set steer to HEADING(head, output).
  set t to output.

  // forward speed pid loop
  // set v1 to ship:velocity:surface.
  // set current_gr to v1 - up:forevector * vdot(v1, up:forevector).
  // print current_gr.
  // set d_gr to current_gr - target_gr.
  // set o to o + hpid:UPDATE(TIME:SECONDS, d_gr).
  // //print o.
  // set s_rot to SHIP:FACING - R(o, 0, 0).

  //if ap_running preserve.
  wait 0.01.
}
