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
wait until ALT:RADAR <= 1500.
print "deploy drogue chute".
wait until STAGE:READY.
stage.

// main chute
wait until ALT:RADAR <= 750.
print "deploy main chute".
wait until STAGE:READY.
stage.

// heatshield
wait 5.
print "drop heatshield".
wait until STAGE:READY.
stage.

// stage landing rockets
wait until ALT:RADAR <= 250.
print "stage landing rockets".
wait until STAGE:READY.
stage.


// initiate landing sequence

//lock steering to UP.

run lib_hover.
//print alt.

wait until ALT:RADAR <= 100.
print "initiate landing sequence".
// initiate landing sequence
//set speed to 5.

//print SHIP:VERTICALSPEED.

set vd to vecdraw(v(0,0,0), 5*ship:facing:upvector).
set vd:show to true.
set vd:label to "UP".

set target_climbrate to -5.
set target_upspeed to -8.

lock steering to up + R(0, 0, 0).

until false {

  print "LOOP".
  set vd to vecdraw(v(0,0,0), 5*ship:facing:upvector).
  set vd:show to true.
  set vd:label to "UP".

  if alt:radar <= 50 {
    run_hover().

    if alt:radar <= 10 {
      // cut parachute
      if cut {
        ag1 on.
        set cut to false.
      }
      if alt:radar <= 10 {
        set target_climbrate to -2.
        if alt:radar <= 5 {
          set target_climbrate to -1.
          if alt:radar <= 1 {
            stage.
          }
        }
      }
    }
  }
  wait 0.01.
}

// SHIP:VELOCITY:SURFACE:MAG
