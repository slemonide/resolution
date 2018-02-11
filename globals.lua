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
    MACHINEGUN_DELAY = 0.02,

    MAX_SLIMES = 16,
    SLIME_VIEW_RANGE = 100
}


globals = {}

local Music = require("music")
local Surface = require("surface")
local Slime = require("slime")
local Pill = require("pill")
local Hud = require("hud")
local Camera = require("lib.hump.camera")
local EightBit = require("eightBit")

function globals:load()
    globals.world = wf.newWorld(0, 0, false)
    globals.world:setGravity(0, 512)
    globals.world:setQueryDebugDrawing(true)
    globals.music = Music()

    globals.world:addCollisionClass('Player')
    globals.world:addCollisionClass('Good Slime')
    globals.world:addCollisionClass('Bad Slime')
    globals.world:addCollisionClass('Good Bullet')
    globals.world:addCollisionClass('Bad Bullet')


    globals.eightBit = EightBit()
    globals.surface = Surface()
    globals.slimes = {}

    for i = 1, CONFIG.MAX_SLIMES do
        local x = math.random(CONFIG.XSIZE)
        table.insert(globals.slimes, Slime(vector(x,globals.surface:getY(x) - math.random(50)), 20 + math.random(20), 5))
    end

    globals.pill = Pill(vector(1100, -2000))
    globals.bullets = {}

    globals.camera = Camera()
    globals.update_delay = 0

    globals.game_over = false

    globals.hud = Hud()
end