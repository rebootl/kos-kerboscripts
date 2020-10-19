//
// launch script for rocket: Picard B1
//
//CLEARSCREEN.

// lock stuff
LOCK THROTTLE TO 1.0.
LOCK STEERING TO HEADING(90, 90).

// countdown
WAIT 1.
PRINT "Counting down:".
PRINT "3.. 2.. 1.. go..".
PRINT "Ignition...".
STAGE.

// pitch over
WAIT UNTIL SHIP:VELOCITY:SURFACE:MAG >= 120.
PRINT "Pitch over...".
LOCK STEERING TO HEADING(90, 90 * (1 - APOAPSIS / 72000)).

// stage boosters
WAIT UNTIL SHIP:PARTSTAGGED("LFB1")[0]:FLAMEOUT.
PRINT "Booster sep...".
// give some time to "unload"
WAIT 2.
STAGE.

// stage 1st stage
WAIT UNTIL STAGE:LIQUIDFUEL = 0.
PRINT "1st stage empty - sep.".
PRINT "Stage, stage...!".
STAGE.

// coasting
WAIT UNTIL SHIP:APOAPSIS >= 72000.
PRINT "Apoapsis 72k, coasting...".
LOCK THROTTLE TO 0.

// circularize
WAIT UNTIL ETA:APOAPSIS <= 30.
PRINT "Circularize...".
LOCK THROTTLE TO 1.

WAIT UNTIL SHIP:PERIAPSIS >= 70000.
LOCK THROTTLE TO 0.
PRINT "Orbit pog.".

//This sets the user's throttle setting to zero to prevent the throttle
//from returning to the position it was at before the script was run.
SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.
