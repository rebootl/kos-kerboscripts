//
//

// lock stuff
lock throttle to 0.0.
lock steering to UP.

//lock vel to SHIP:VERTICALSPEED.
//set alt to ALT:RADAR.

set cut to true.

// testbed
stage.
wait until SHIP:VERTICALSPEED >= 20.
lock steering to Up + R(15,0,0).

wait until SHIP:PARTSTAGGED("S1")[0]:FLAMEOUT.
// solidbooster
stage.

unlock steering.

wait until SHIP:VERTICALSPEED <= 5.
// fairing.
wait until STAGE:READY.
stage.
// drogue chute
print "deploy drogue chute".
wait until STAGE:READY.
stage.

wait until ALT:RADAR <= 750.
// main chute
print "deploy main chute".
wait until STAGE:READY.
stage.

wait until ALT:RADAR <= 700.
// heatshield
print "drop heatshield".
wait until STAGE:READY.
stage.

wait until ALT:RADAR <= 250.
// initiate landing rockets
print "initiate landing rockets".
wait until STAGE:READY.
stage.

lock steering to UP.

//print alt.

wait until ALT:RADAR <= 100.
print "initiate landing sequence".
// initiate landing sequence
set speed to 5.

print SHIP:VERTICALSPEED.

until ALT:RADAR <= 0.1 {

  if ALT:RADAR <= 80 {
    // -> cut parachutes (once)
    if cut {
      set ag1 to true.
      set cut to false.
    }
    set speed to (ALT:RADAR / 5).
  }

  if ALT:RADAR <= 0.5 {
    lock throttle to 0.7.
    stage.
  }

  if abs(SHIP:VERTICALSPEED) > speed {
    lock throttle to 1.
  }
  else {
    lock throttle to 0.
  }
  wait 0.01.
}

// SHIP:VELOCITY:SURFACE:MAG
