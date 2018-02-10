------------------------------------------------------------------------
-- The bottom solid surface
------------------------------------------------------------------------

local function init_vertices(vertices)
    local coefficients = {}
    local coefficients2 = {}
    local coefficients3 = {}

    for i = 1, CONFIG.SURFACE_COMPLEXITY do
        table.insert(coefficients, math.random() * 2 - 1)
        table.insert(coefficients2, math.random())
        table.insert(coefficients3, math.random())
    end

    local function surface(i)
        local out = 50

        for j = 1, CONFIG.SURFACE_COMPLEXITY do
            out = out + math.sin(math.pi*j^coefficients3[j]/2*i/CONFIG.XSIZE + 2 * math.pi * coefficients2[j]) * coefficients[j]
                    + math.sin(math.pi*j^(0.2+coefficients3[j])/2*i/CONFIG.XSIZE + 2 * math.pi * coefficients2[j]) * coefficients[j]
        end

        return 10*out
    end

    table.insert(vertices, 0)
    table.insert(vertices, 1000)
    for i = 0,CONFIG.XSIZE do
        table.insert(vertices, i)
        table.insert(vertices, surface(i))
    end
    table.insert(vertices, CONFIG.XSIZE)
    table.insert(vertices, 1000)
end

local Surface = Class{
    init = function(self)
        self.vertices = {}
        init_vertices(self.vertices)

        self.collision_map = globals.world:newChainCollider(true, self.vertices)
        self.collision_map:setType('static')
    end
}

function Surface:draw()
    love.graphics.setColor(255, 0, 0)
    love.graphics.polygon('fill', self.vertices)
end

return Surface