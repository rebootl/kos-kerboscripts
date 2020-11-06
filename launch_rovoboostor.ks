//
// launch script for rocket: probootl II
//
//CLEARSCREEN.

// lock stuff
LOCK THROTTLE TO 1.0.
LOCK STEERING TO HEADING(90, 90).

// countdown
PRINT "Counting down:".
FROM { LOCAL countdown IS 3. } UNTIL countdown = 0 STEP
     { SET countdown TO countdown - 1. } DO {
    PRINT "..." + countdown.
    WAIT 1.
}
PRINT "Ignition...".
STAGE.

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
LOCK STEERING TO HEADING(90, 90 - 90 * APOAPSIS / 75000).

// -> stage boosters
//WAIT UNTIL STAGE:SOLIDFUEL < 10.
WAIT UNTIL SHIP:PARTSTAGGED("S1")[0]:FLAMEOUT.
PRINT "Stage 1 sep...".
// give some time to "unload"
//WAIT 3.
STAGE.
// init 2nd stage
WAIT UNTIL STAGE:READY.
STAGE.

// START COASTING
WAIT UNTIL SHIP:APOAPSIS >= 75000.
PRINT "Apoapsis, coasting...".
LOCK THROTTLE TO 0.

// DEPLOY FAIRING
//wait until ship:apoapsis >= 60000.
stage.

// START CIRCULARIZATION
WAIT UNTIL ETA:APOAPSIS <= 17.5.
PRINT "Apoapsis reached".
LOCK THROTTLE TO 1.

//WAIT UNTIL STAGE:LIQUIDFUEL = 0.
//PRINT "2st stage empty - sep.".
//STAGE.
// init 3nd stage
//WAIT UNTIL STAGE:READY.
//STAGE.

WAIT UNTIL SHIP:PERIAPSIS >= 70000.
LOCK THROTTLE TO 0.

LOCK STEERING TO PROGRADE.

//This sets the user's throttle setting to zero to prevent the throttle
//from returning to the position it was at before the script was run.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
