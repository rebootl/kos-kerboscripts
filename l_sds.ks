
stage.

// runway
lock steering to heading(90, 0).
lock throttle to 1.0.

// 'roll'
wait until ship:velocity:surface:mag >= 100.
lock steering to heading(90, 10).

wait until alt:radar >= 150.
lock steering to heading(90, 15).

wait until ship:apoapsis >= 72000.
lock throttle to 0.

lock steering to prograde.

stage.

wait 10.

// circularize
// ...

set l to false.
until l {

  set e to eta:apoapsis.

  lock throttle to 1.
  wait eta:apoapsis * 0.1.

  if eta:apoapsis > e {
    lock throttle to 0.
    wait eta:apoapsis * 0.25.
  }

  if ship:periapsis >= 72000 {
    lock throttle to 0.
    set l to true.
  }
}

//wait until ship:partstagged("s1")[0]:flameout.


//this sets the user's throttle setting to zero to prevent the throttle
//from returning to the position it was at before the script was run.
set ship:control:pilotmainthrottle to 0.