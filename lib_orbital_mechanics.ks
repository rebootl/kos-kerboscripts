@lazyglobal off.
parameter export is {
  parameter target.
  global om is target.
}.
{
  set PI to Constant:PI.

  function get_elliptical_period {
    parameter r_A.
    parameter r_B.

    // test orbit 80km
    //set r_1 to 680000.
    // semi-major axis
    local a is (r_A + r_B) / 2.

    // calculate transfer period
    // P = 2PI * sqrt(a^3/MU)
    return 2 * PI * SQRT((a*a*a) / BODY:MU).
  }

  function get_phase_angle {
    parameter P_transfer.
    parameter target_body.
    return 180 - (P_transfer * 360) / (2 * target_body:ROTATIONPERIOD).
  }

  function get_transfer_dv {
    parameter r_A.
    parameter r_B.

    // semimajor axis of transfer ellipse
    local a_t is (r_A + r_B) / 2.

    local v_0 is SHIP:ORBIT:VELOCITY:ORBIT:MAG.
    local v_t is SQRT(BODY:MU * ((2 / r_A) - (1 / a_t))).
    return v_t - v_0.
  }

  function get_burn_time {
    Parameter dV.
    Parameter engine.

    local isp is engine:VISP.
    local F_thrust is engine:POSSIBLETHRUST * 1000.
    local m_0 is SHIP:MASS * 1000.

    local v_e is Constant:g0 * isp.
    local m_dot is F_thrust / v_e.
    return (m_0 / m_dot) * (1 - (1 / Constant:e ^ (dV / v_e))).
  }

  function get_vangle {
    Parameter norm, a, b.

    local c is vcrs(norm, a).
    local ang is vang(a, b).
    if (vdot(c, b) > 1) {
      return 360 - ang.
    } else {
      return ang.
    }
  }

  function get_circ_angle_from_time {
    Parameter t.
    Parameter orb.
    return (t * 360) / orb.
  }

  function get_circ_time_from_angle {
    Parameter angle.
    Parameter P.
    local t is (P * angle) / 360.
    if (t < 0) {
      return (P + t).
    }
    return t.
  }

  export(lex(
    "get_elliptical_period", get_elliptical_period@,
    "get_phase_angle", get_phase_angle@,
    "get_transfer_dV", get_transfer_dV@,
    "get_burn_time", get_burn_time@,
    "get_vangle", get_vangle@,
    "get_circ_angle_from_time", get_circ_angle_from_time@,
    "get_circ_time_from_angle", get_circ_time_from_angle@
  )).
}
