// a maneuvering computer for probes / spaceships
//

// set ship engine
local engine to SHIP:PARTSTAGGED("LE3")[0].

// orbital mech. lib.
set PI to Constant:PI.
run once "lib_orbital_mechanics".

// gui import
local g IS GUI(400).
local ids IS LEX().
run "maneuver_gui.ks"(g, ids).
g:SHOW().

// gui buttons
set ids["steering_prograde"]:ONCLICK to steering_prograde@.
set ids["steering_retrograde"]:ONCLICK to steering_retrograde@.
set ids["steering_normal"]:ONCLICK to steering_normal@.
set ids["steering_antinormal"]:ONCLICK to steering_antinormal@.
set ids["steering_radialin"]:ONCLICK to steering_radialin@.
set ids["steering_radialout"]:ONCLICK to steering_radialout@.
set ids["steering_unlock"]:ONCLICK to steering_unlock@.
set ids["run_node"]:ONCLICK to run_next_node@.
set ids["stop_node"]:ONCLICK to stop_next_node@.

set ids["auto_burn"]:TEXT to "OFF".

// loop control
set loop_node to false.

// directions
// prograde (built-in)
// retrograde (built-in)
// normal
lock normal to vcrs(ship:velocity:orbit, -body:position).
// anti-normal
lock antinormal to -normalvec.
// radial-in
lock radialin to vcrs(ship:velocity:orbit, normal).
// radial-out
lock radialout to -radialin.

function steering_prograde {
  lock steering to prograde.
  set ids["current_steering"]:text to "PROGRADE".
}

function steering_retrograde {
  lock steering to retrograde.
  set ids["current_steering"]:text to "RETROGRADE".
}

function steering_normal {
  lock steering to normal.
  set ids["current_steering"]:text to "NORMAL".
}

function steering_antinormal {
  lock steering to antinormal.
  set ids["current_steering"]:text to "ANTI-NORMAL".
}

function steering_radialin {
  lock steering to radialin.
  set ids["current_steering"]:text to "RADIAL-IN".
}

function steering_radialout {
  lock steering to radialout.
  set ids["current_steering"]:text to "RADIAL-OUT".
}

function steering_unlock {
  unlock steering.
  set ids["current_steering"]:text to "UNLOCKED".
}

function run_next_node {
  if not hasnode {
    print "No maneuver node found, returning...".
    return.
  }
  if loop_run {
    print "Maneuver already running, stop first!".
    return.
  }
  local n is nextnode.
  local dv is n:deltav:mag.
  print "dv: " + dv.
  local burn_time is om:get_burn_time(dv, engine).
  print "burn time: " + burn_time.
  local burn_time_p1 is om:get_burn_time(dv / 2, engine).
  print "burn time p1: " + burn_time_p1.

  set loop_run to true.
  //until not loop_run {
  on time:seconds {
    local eta is n:eta.
    local t_start is eta - burn_time_p1.
    if eta <= 0 or t_start <= 0 {
      set loop_run to false.
      print "node passed, stopping loop".
    }
    //print "time to burn: " + t_start.
    if loop_run {
      set ids["auto_burn"]:TEXT to "ETA burn:" + round(t_start, 2):tostring.
    } else {
      set ids["auto_burn"]:TEXT to "OFF".
    }
    if t_start <= 0 and loop_run {
      print "burn!".
      // on time:seconds will always run, so stop preserving here!
      set loop_run to false.
      lock throttle to 1.
      wait burn_time.
      lock throttle to 0.
    }
    //wait 0.1.
    if loop_run preserve.
  }
  //print "maneuver completed/aborted".
}

function stop_next_node {
  set loop_run to false.
  //set ids["auto_burn"]:TEXT to "OFF".
}

// keep running
wait until false.
