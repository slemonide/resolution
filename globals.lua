------------------------------------------------------------------------
-- This is the only place where global variables should be defined
-- Feel free to add anything here that is used often enough
------------------------------------------------------------------------

Class = require "lib.hump.class"
vector = require "lib.hump.vector"
wf = require "lib.windfield"
ripple = require "lib/ripple"

CONFIG = {
    XSIZE = 12000,
    SURFACE_COMPLEXITY = 40,
    SLIME_CIRCLE_COMPONENTS_RADIUS = 3,
    SLIME_IMPULSE = 5,
    SURFACE_RESTITUTION = 0.3,

    SLIME_BAD_COLOR = vector(255, 0),
    SLIME_GOOD_COLOR = vector(61, 71),
    SLIME_JUMP_STRENGTH = 60,
    PILL_JUMP_STRENGTH = 400,
    PILL_IMPULSE = 15,
    BULLET_SPEED = 900,
    INITIAL_SLIME_HP = 100,
    MAX_BULLETS = 100,
    UPDATE_DELAY = 0.01,

    MAX_SLIMES = 16
}


globals = {}
local Surface = require("surface")
local Slime = require("slime")
local Pill = require("pill")
local Music = require("music")
local Camera = require("lib.hump.camera")

function globals:load()
    globals.world = wf.newWorld(0, 0, true)
    globals.world:setGravity(0, 512)
    globals.world:addCollisionClass('Slime')
    globals.world:addCollisionClass('Bullet')

    globals.surface = Surface()
    globals.slimes = {}
    for i = 1, CONFIG.MAX_SLIMES do
        local x = math.random(CONFIG.XSIZE)
        table.insert(globals.slimes, Slime(vector(x,globals.surface:getY(x) - math.random(50)), 20 + math.random(20), 5))
    end

    globals.pill = Pill(vector(CONFIG.XSIZE/2,globals.surface:getY(CONFIG.XSIZE/2)-10))
    globals.bullets = {}
    globals.music = Music()
    globals.camera = Camera()
    globals.update_delay = 0
end