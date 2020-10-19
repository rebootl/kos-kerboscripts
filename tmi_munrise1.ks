// trans-munar-injection for munrise-1
//
set PI to Constant:PI.

run once "lib_orbital_mechanics".

/// settings
set target_body to Mun.
// insert orbit 100km above surface 200km
set insert_orb_r to 300_000.
set engine to SHIP:PARTSTAGGED("LE3")[0].

/// calculations
// target_radius_apo is insert height above Mun/target_body
set target_radius_apo to target_body:APOAPSIS + Body:RADIUS + insert_orb_r.

// assuming circular orbit
set r_orbit to (SHIP:APOAPSIS + SHIP:PERIAPSIS) / 2 + Body:RADIUS.

set P_transfer to om:get_elliptical_period(r_orbit, target_radius_apo).
print "Transfer Period: " + P_transfer.

set phase_angle to om:get_phase_angle(P_transfer, target_body).
print "Phase Angle: " + phase_angle.

function recalc {
  set transfer_dv to om:get_transfer_dv(r_orbit, target_radius_apo).
  print "Transfer dV: " + transfer_dv.

  set burn_time to om:get_burn_time(transfer_dv, engine).
  print "Burn Time: " + burn_time.

  set burn_time_1st to om:get_burn_time(transfer_dv / 2, engine).
  print "Burn Time 1st part: " + burn_time_1st.
  print "Burn Time 2nd part: " + (burn_time - burn_time_1st).

  set normal to VCRS(SHIP:VELOCITY:ORBIT, -Body:POSITION).
  set current_angle to om:get_vangle(normal, -Body:POSITION, target_body:POSITION - Body:POSITION).
  print "Current Angle: " + current_angle.

  set angle_corr to om:get_circ_angle_from_time(burn_time_1st, SHIP:ORBIT:PERIOD).
  print "Angle Corr.: " + angle_corr.

  set corr_phase_angle to phase_angle + angle_corr.
  set approx_time_to_burn to om:get_circ_time_from_angle((current_angle - corr_phase_angle), SHIP:ORBIT:PERIOD).
  print "Approx. Time to Burn: " + approx_time_to_burn / 60.
}

/// run
lock steering to prograde.
print "Calculation Run 1.".
print "Wait for T - 5min.".
recalc().
wait approx_time_to_burn - 300.
print "Calculation Run 2.".
print "Wait for T - 5min.".
recalc().
wait approx_time_to_burn - 60.
print "Calculation Run 3.".
print "Wait for T - 10sec.".
recalc().
wait approx_time_to_burn - 10.
print "Calculation Run 4.".
print "Wait for T - 1sec.".
recalc().
wait approx_time_to_burn - 1.
wait approx_time_to_burn.
print "Waited enough... Buuuurn!".
recalc().
lock throttle to 1.
wait burn_time.
lock throttle to 0.
print "Done. Check de orbit...".
