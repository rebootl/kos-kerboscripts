//
//

// target climbrate
set target_climbrate to 0.

// target groundspeed, horizontal velocity forward
//set target_pitchrate to 0.
set target_upspeed to 0.
set target_starspeed to 0.
set roll to 0.

// inputs / controls
on AG1 {
  set target_climbrate to target_climbrate - 1.
  print "Climbrate set: " + target_climbrate.
  preserve.
}

on AG4 {
  set target_climbrate to target_climbrate + 1.
  print "Climbrate set: " + target_climbrate.
  preserve.
}

on AG5 {
  set target_upspeed to target_upspeed + 1.
  print "Upspeed set: " + target_upspeed.
  preserve.
}

on AG6 {
  set target_upspeed to target_upspeed - 1.
  print "Upspeed set: " + target_upspeed.
  preserve.
}

on AG2 {
  set target_starspeed to target_starspeed + 1.
  print "Starspeed set: " + target_starspeed.
  preserve.
}

on AG3 {
  set target_starspeed to target_starspeed - 1.
  print "Starspeed set: " + target_starspeed.
  preserve.
}

on AG7 {
  set roll to roll + 15.
  print "Roll set: " + roll.
  preserve.
}

on AG9 {
  set roll to roll - 15.
  print "Roll set: " + roll.
  preserve.
}


// pid for climbrate/throttle
set kp to 0.1.
set ki to 0.01.
set kd to 0.01.

set pid to PIDLOOP(kp, ki, kd).
set pid:SETPOINT to 0.

//set t to 0.7.
set output_throttle to 0.7.
lock throttle to output_throttle.

// pid for up velocity/pitch (horizontal)
set lp to 1.0.
set li to 0.0.
set ld to 0.0.

set ppid to PIDLOOP(lp, li, ld).
set ppid:SETPOINT to 0.
set output_pitch to 0.
//lock steering to up + R(output_pitch, 0, 0).

// pid for up velocity/yaw (horizontal)
set yp to 1.0.
set yi to 0.0.
set yd to 0.0.

set ypid to PIDLOOP(yp, yi, yd).
set ypid:SETPOINT to 0.
set output_yaw to 0.

lock steering to up + R(output_pitch, output_yaw, roll).

//set ap_running to true.
//on TIME:SECONDS {
until false {
  // climbrate/throttle pid loop
  set current_climbrate to SHIP:VERTICALSPEED.
  set d_climbrate to current_climbrate - target_climbrate.

  set output_throttle to output_throttle + pid:UPDATE(TIME:SECONDS, d_climbrate).
  //print output_throttle.

  // pitchrate/pitch pid loop
  //set current_fs to ship:velocity:surface * ship:facing:upvector.
  //print current_fs.
  //set current_pitchrate to ship:angularvel * ship:facing:starvector.
  //print current_pitchrate.
  //set d_pitchrate to current_pitchrate - target_pitchrate.
  //set output_pitch to output_pitch - ppid:UPDATE(TIME:SECONDS, d_pitchrate).
  //set ship:control:pitch to output_pitch.

  // horizontal velocity/pitch (ship direction up) pid loop
  set current_upspeed to ship:velocity:surface * ship:facing:upvector.
  set d_speed to target_upspeed - current_upspeed.
  set output_pitch to ppid:UPDATE(TIME:SECONDS, d_speed).
  //print output_pitch.
  //lock steering to up + R(-output_pitch, 0, 0).

  // horizontal velocity/yaw (ship direction star) pid loop
  set current_starspeed to ship:velocity:surface * ship:facing:starvector.
  set d_starspeed to target_starspeed - current_starspeed.
  set output_yaw to ypid:UPDATE(TIME:SECONDS, d_starspeed).
  //print output_yaw.

  lock steering to up + R(output_pitch, -output_yaw, roll).

  // horizontal velocity in pitch (ship direction up) p-loop
  //set current_upspeed to ship:velocity:surface * ship:facing:upvector.
  //set d_speed to current_upspeed - target_upspeed.
  //set pitch_angle to d_speed.
  //print pitch_angle.
  //lock steering to up + R(pitch_angle, 0, 0).

  //if ap_running preserve.
  wait 0.01.
}
