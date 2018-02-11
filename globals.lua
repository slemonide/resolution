------------------------------------------------------------------------
-- This is the only place where global variables should be defined
-- Feel free to add anything here that is used often enough
------------------------------------------------------------------------

Class = require "lib.hump.class"
vector = require "lib.hump.vector"
wf = require 'lib.windfield'

globals = {}
local Surface = require("surface")
local Slime = require("slime")
local Pill = require("pill")

function globals:load()
    globals.world = wf.newWorld(0, 0, true)
    globals.world:setGravity(0, 512)

    globals.surface = Surface()

    globals.slime = Slime(vector(200,400))
    globals.pill = Pill(vector(200,400))
end

CONFIG = {
    XSIZE = 2000,
    SURFACE_COMPLEXITY = 40,
    SLIME_CIRCLE_COMPONENTS_RADIUS = 3,
    SLIME_IMPULSE = 10,
    SURFACE_RESTITUTION = 0.3
}