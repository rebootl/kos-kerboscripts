//
// launch script for rocket: munrise 1
//
//CLEARSCREEN.

// lock stuff
LOCK THROTTLE TO 1.0.
LOCK STEERING TO HEADING(90, 90).

// countdown
PRINT "Counting down:".
//FROM { LOCAL countdown IS 10. } UNTIL countdown = 0 STEP
//     { SET countdown TO countdown - 1. } DO {
//    PRINT "..." + countdown.
//    WAIT 1.
//}
PRINT "3.. 2.. 1.. go..".
PRINT "Ignition...".
STAGE.
//WAIT UNTIL STAGE:READY.
//STAGE.
// -> use wait until here ??
//SET turn_init TO false.
//UNTIL turn_init = true {
//  IF SHIP:VELOCITY:SURFACE:MAG >= 100 {
//    LOCK STEERING TO HEADING(90, 90 - 90 * APOAPSIS / 80000).
//    turn_init = true.
//  }
//  WAIT 0.5.
//}
WAIT UNTIL SHIP:VELOCITY:SURFACE:MAG >= 100.
PRINT "Pitch over...".
LOCK STEERING TO HEADING(90, 90 - 90 * APOAPSIS / 80000).

// -> stage boosters
WAIT UNTIL SHIP:PARTSTAGGED("LFB1")[0]:FLAMEOUT.
PRINT "Booster sep...".
// give some time to "unload"
WAIT 2.
STAGE.

WAIT UNTIL STAGE:LIQUIDFUEL = 0.
PRINT "1st stage empty - sep.".
PRINT "Stage, stage...!".
STAGE.
WAIT UNTIL STAGE:READY.
STAGE. // init 2nd stage

WAIT UNTIL SHIP:APOAPSIS >= 80000.
PRINT "Apoapsis 80k, coasting...".
LOCK THROTTLE TO 0.

WAIT UNTIL ETA:APOAPSIS <= 20.
PRINT "Apoapsis reached".
LOCK THROTTLE TO 1.

WAIT UNTIL SHIP:PERIAPSIS >= 75000.
LOCK THROTTLE TO 0.

LOCK STEERING TO PROGRADE.

//This sets the user's throttle setting to zero to prevent the throttle
//from returning to the position it was at before the script was run.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
