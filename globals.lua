------------------------------------------------------------------------
-- This is the only place where global variables should be defined
-- Feel free to add anything here that is used often enough
------------------------------------------------------------------------

Class = require "lib.hump.class"
vector = require "lib.hump.vector"
wf = require "lib.windfield"
ripple = require "lib/ripple"

globals = {}
local Surface = require("surface")
local Slime = require("slime")
local Pill = require("pill")
local Music = require("music")
local Camera = require("lib.hump.camera")

function globals:load()
    globals.world = wf.newWorld(0, 0, true)
    globals.world:setGravity(0, 512)

    globals.surface = Surface()
    globals.slime = Slime(vector(200,400), 30, 16)
    globals.pill = Pill(vector(250,400))
    globals.bullets = {}
    globals.music = Music()
    globals.camera = Camera()
end

CONFIG = {
    XSIZE = 12000,
    SURFACE_COMPLEXITY = 40,
    SLIME_CIRCLE_COMPONENTS_RADIUS = 3,
    SLIME_IMPULSE = 5,
    SURFACE_RESTITUTION = 0.3,
    PILL_IMPULSE = 15,
    BULLET_SPEED = 900
}