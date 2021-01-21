//
// launch script for rocket: probootl II
//

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

// initiate rotation
WAIT UNTIL SHIP:VELOCITY:SURFACE:MAG >= 100.
PRINT "Pitch over...".
LOCK STEERING TO HEADING(90, 90 - 90 * APOAPSIS / 105000).

// stage boosters
WAIT UNTIL SHIP:PARTSTAGGED("S1")[0]:FLAMEOUT.
PRINT "Stage Boosters!".
// give some time to "unload"
WAIT 2.
STAGE.

// stage 1
WAIT UNTIL SHIP:PARTSTAGGED("LF1")[0]:FLAMEOUT.
PRINT "Stage 1 sep...".
WAIT UNTIL STAGE:READY.
STAGE.

// coasting
WAIT UNTIL SHIP:APOAPSIS >= 102000.
PRINT "Apoapsis, coasting...".
LOCK THROTTLE TO 0.

// fairing
//wait until ship:apoapsis >= 60000.

// circularization
WAIT UNTIL ETA:APOAPSIS <= 25.
PRINT "Apoapsis reached".
LOCK THROTTLE TO 1.

WAIT UNTIL SHIP:PERIAPSIS >= 100000.
LOCK THROTTLE TO 0.

LOCK STEERING TO PROGRADE.

//This sets the user's throttle setting to zero to prevent the throttle
//from returning to the position it was at before the script was run.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
