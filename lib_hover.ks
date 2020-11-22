//
//

// target climbrate
global target_climbrate to 0.

// target groundspeed, horizontal velocity forward
//set target_pitchrate to 0.
global target_upspeed to 0.
global target_starspeed to 0.
global roll to 0.

// pid for climbrate/throttle
local kp to 0.1.
local ki to 0.01.
local kd to 0.01.

local pid to PIDLOOP(kp, ki, kd).
set pid:setPOINT to 0.

//local t to 0.7.
local output_throttle to 0.
lock throttle to output_throttle.

// pid for up velocity/pitch (horizontal)
local lp to 1.0.
local li to 0.0.
local ld to 0.0.

local ppid to PIDLOOP(lp, li, ld).
set ppid:setPOINT to 0.
local output_pitch to 0.
//lock steering to up + R(output_pitch, 0, 0).

// pid for up velocity/yaw (horizontal)
local yp to 1.0.
local yi to 0.0.
local yd to 0.0.

local ypid to PIDLOOP(yp, yi, yd).
set ypid:setPOINT to 0.
local output_yaw to 0.

//lock steering to up + R(output_pitch, output_yaw, roll).

//set ap_running to true.
//on TIME:SECONDS {
function run_hover {
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
  //wait 0.01.
}
