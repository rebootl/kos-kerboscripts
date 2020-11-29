
local PI is Constant:PI.

run once "lib_orbital_mechanics".


local t is Duna.
local engine is SHIP:PARTSTAGGED("LE3")[0].

// current parking orbit radius
local r_p is (ship:orbit:apoapsis + ship:orbit:periapsis) / 2.

// target planet radius
local r_2 is (t:orbit:apoapsis + t:orbit:periapsis) / 2.
print "Target body radius: " + r_2.

// current planet radius
local r_1 is (body:orbit:apoapsis + body:orbit:periapsis) / 2.
print "Current radius: " + r_1.

// transfer period (half period)
local t_h is om:get_elliptical_period(r_1, r_2, Sun:mu) / 2.
print "Transfer period: " + t_h.
//print "Duna period: " + Duna:rotationperiod.

// phase angle
local phi is 180 - (360 / t:orbit:period * t_h).
print "Phase Angle: " + phi.

// dv transfer (hohman)
function get_transfer_dv {
  parameter r_1.
  parameter r_2.
  parameter mu.
  return sqrt(mu/r_1) * (sqrt((2*r_2)/(r_1 + r_2)) - 1).
}

local dv_transfer is get_transfer_dv(r_1, r_2, Sun:mu).
print "Transfer dv: " + dv_transfer.

local a is (r_1 + r_2) / 2.
local v_2 is sqrt(Sun:mu * (2 / r_1 - 1 / a)) - sqrt(Sun:mu / r_1).
print "v2: " + v_2.
local dv_eject is sqrt(
  ( r_p * ( body:soiradius * v_2 * v_2 - 2 * body:mu ) + 2 * body:soiradius * body:mu ) /
  ( r_p * body:soiradius )
).
print "Eject dv: " + dv_eject.
