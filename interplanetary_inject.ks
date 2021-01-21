
set PI to Constant:PI.

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


// v_s velocity hohman transfer start (absolute)
// - braeunig 4.61
local v_s is sqrt( Sun:mu * ( (2*r_2) / (r_1 * (r_1 + r_2)) ) ).
print "v_s: " + v_s.

// v_sp velocity hohman transfer start (relative)
// v_s minus velocity of the planet
// - braeunig 5.33
local v_p is (2*pi*r_1) / body:orbit:period.
//local v_p is sqrt(Sun:mu / r_1).
print "v_p: " + v_p.
local v_sp is v_s - v_p.
print "v_sp: " + v_sp.

// launch velocity
// - braeunig 5.35
local v_0 is sqrt( v_sp*v_sp + (2*body:mu) / r_p ).

// dv
local dv is v_0 - sqrt( body:mu / r_p ).
print "dv: " + dv.

// ejection angle
local eps is v_sp*v_sp / 2 - body:mu / r_p.
local h is r_p * sqrt(body:mu / r_p).
local _e is sqrt( 1 + (2*eps*h*h) / (body:mu*body:mu)).
local theta is rad2deg(arccos(1/_e)).


// dv transfer (hohman)
// function get_transfer_dv {
//   parameter r_1.
//   parameter r_2.
//   parameter mu.
//   return sqrt(mu/r_1) * (sqrt((2*r_2)/(r_1 + r_2)) - 1).
// }
//
// local dv_transfer is get_transfer_dv(r_1, r_2, Sun:mu).
// print "Transfer dv: " + dv_transfer.
//
// local a is (r_1 + r_2) / 2.
// local v_2 is sqrt(Sun:mu * (2 / r_1 - 1 / a)) - sqrt(Sun:mu / r_1).
// print "v2: " + v_2.
// local dv_eject is sqrt(
//   ( r_p * ( body:soiradius * v_2 * v_2 - 2 * body:mu ) + 2 * body:soiradius * body:mu ) /
//   ( r_p * body:soiradius )
// ).
// print "Eject dv: " + dv_eject.
