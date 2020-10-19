// simple aircraft autopilot
//

local g IS GUI(400).
local ids IS LEX().
run "gui_autopilot.ks"(g, ids).
g:SHOW().
set ids["toggle_ap"]:ONCLICK to toggle_autopilot@.
set ids["update_ap"]:ONCLICK to update_ap@.

local myautopilot is autopilot().

// init gui w values
local pid_values is autopilot:get_pid_values().
set ids["kp_input"]:TEXT to pid_values[0]:TOSTRING.
set ids["ki_input"]:TEXT to pid_values[1]:TOSTRING.
set ids["kd_input"]:TEXT to pid_values[2]:TOSTRING.

function update_ap {
  myautopilot:set(
    ids["target_cr"]:TEXT,
    ids["kp_input"]:TEXT,
    ids["ki_input"]:TEXT,
    ids["kd_input"]:TEXT
  ).
}

function toggle_autopilot {
  if not myautopilot["state"]() {
    //local kp is ids["kp_input"]:TEXT.
    update_ap().
    myautopilot["enable"]().
    set ids["toggle_ap"]:TEXT to "Off".
  } else {
    myautopilot["disable"]().
    set ids["toggle_ap"]:TEXT to "On".
  }
}

on SHIP:VERTICALSPEED {
  set ids["curr_cr"]:TEXT to round(SHIP:VERTICALSPEED, 3):TOSTRING.
  preserve.
}

function autopilot {
  //parameter target_altitude.

  local _pitch_angle_max is 5.
  local _ap_running is false.
  local _target_cr is 0.
  //local _target_altitude is 0.

  // target_altitude pid values:
  // 0.0025, 0.00006, 0.001
  // 0.0045, 0.0001, 0.001

  // target climb rate pid values:
  // 1.0, 0.15, 0.0 - 0.02 ?
  local _kp is 1.0.
  local _ki is 0.15.
  local _kd is 0.02.

  return LEX(
    "set", {
      //parameter target_altitude.
      parameter target_cr.
      parameter kp.
      parameter ki.
      parameter kd.

      //set _target_altitude to target_altitude:TOSCALAR.
      set _target_cr to target_cr:TOSCALAR.
      set _kp to kp:TOSCALAR.
      set _ki to ki:TOSCALAR.
      set _kd to kd:TOSCALAR.
    },
    "enable", {
      print "Autopilot On!".
      print "Target Climbing Rate: " + _target_cr.
      print "Kp: " + _kp.
      set head to -SHIP:BEARING.

      //lock distance to _target_altitude - SHIP:ALTITUDE.

      // do i need this?
      set steer to HEADING(head, 0).
      lock STEERING to steer.

      set PID to PIDLOOP(_kp, _ki, _kd).
      set PID:SETPOINT to 0.

      //set pitch_angle to 90 - VANG(UP:VECTOR, SHIP:FACING:VECTOR).
      //print pitch_angle.
      //lock d to _target_cr - SHIP:VERTICALSPEED.

      lock target_vel_ang to arctan2(_target_cr, SHIP:GROUNDSPEED).
      lock curr_vel_ang to arctan2(SHIP:VERTICALSPEED, SHIP:GROUNDSPEED).
      lock d to curr_vel_ang - target_vel_ang.

      set _ap_running to true.
      on TIME:SECONDS {
        set output to PID:UPDATE(TIME:SECONDS, d).
        //set pitch_angle to MAX(MIN(output, _pitch_angle_max), -_pitch_angle_max).
        //PRINT pitch_angle.
        set steer to HEADING(head, output).
        if _ap_running preserve.
      }
    },
    "disable", {
      set _ap_running to false.
      unlock STEERING.
      print "Autopilot Off!".
    },
    "state", {
      return _ap_running.
    },
    "get_pid_values", {
      return list(_kp, _ki, _kd).
    },
    "lextest", 100
  ).

}
wait until false.
