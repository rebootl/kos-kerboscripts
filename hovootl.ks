//
//

// target climbrate
set target_climbrate to 0.

// target groundspeed, horizontal velocity forward
//set target_pitchrate to 0.

set target_upspeed to -2.

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

lock steering to up + R(0, 0, 0).

// inputs
on AG1 {
  set target_climbrate to target_climbrate - 1.
  print target_climbrate.
  preserve.
}

on AG4 {
  set target_climbrate to target_climbrate + 1.
  print target_climbrate.
  preserve.
}

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
  set d_speed to current_upspeed - target_upspeed.
  set output_pitch to ppid:UPDATE(TIME:SECONDS, d_speed).
  print output_pitch.
  lock steering to up + R(-output_pitch, 0, 0).

  // horizontal velocity in pitch (ship direction up) p-loop
  //set current_upspeed to ship:velocity:surface * ship:facing:upvector.
  //set d_speed to current_upspeed - target_upspeed.
  //set pitch_angle to d_speed.
  //print pitch_angle.
  //lock steering to up + R(pitch_angle, 0, 0).

  //if ap_running preserve.
  wait 0.01.
}
