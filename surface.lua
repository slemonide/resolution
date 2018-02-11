------------------------------------------------------------------------
-- The bottom solid surface
------------------------------------------------------------------------

local coefficients = {}
local coefficients2 = {}
local coefficients3 = {}

local function surface(i)
    local out = 220

    for j = 1, CONFIG.SURFACE_COMPLEXITY do
        out = out + math.sin(math.pi*j^coefficients3[j]/2*i/CONFIG.XSIZE + 2 * math.pi * coefficients2[j]) * coefficients[j]
                + math.sin(math.pi*j^(0.7+coefficients3[j])/2*i/CONFIG.XSIZE + 2 * math.pi * coefficients2[j]) * coefficients[j]
    end

    return 10*out
end

local function init_vertices(vertices)
    for i = 1, CONFIG.SURFACE_COMPLEXITY do
        table.insert(coefficients, math.random() * 2 - 1)
        table.insert(coefficients2, math.random())
        table.insert(coefficients3, math.random())
    end

    table.insert(vertices, 0)
    table.insert(vertices, 10000)
    for i = 0,CONFIG.XSIZE,10 do
        table.insert(vertices, i)
        table.insert(vertices, surface(i))
    end
    table.insert(vertices, CONFIG.XSIZE)
    table.insert(vertices, 10000)
end

local Surface = Class{
    init = function(self)
        self.vertices = {}
        init_vertices(self.vertices)

        self.collision_map = globals.world:newChainCollider(false, self.vertices)
        self.borders = {
            globals.world:newLineCollider(0, 0, 0, 10000),
            globals.world:newLineCollider(CONFIG.XSIZE, 0, CONFIG.XSIZE, 10000)
        }
        self.borders[1]:setType('static')
        self.borders[2]:setType('static')
        self.collision_map:setType('static')
        self.collision_map:setRestitution(CONFIG.SURFACE_RESTITUTION)
    end
}

function Surface:getY(x)
    return surface(x)
end

function Surface:getDerivativeAt(x)
    return self:getY(x + 1) - 2 * self:getY(x) + self:getY(x - 1) -- central scheme
end

function Surface:draw()
    love.graphics.setColor(216, 76, 11)
    love.graphics.polygon('fill', self.vertices)
    love.graphics.setColor(255, 255, 255)
end

return Surface