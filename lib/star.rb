class Star
    COLORS = [
        Gosu::Color::GRAY,
        Gosu::Color::BLUE,
        Gosu::Color::GREEN,
        Gosu::Color::YELLOW
    ]

    def initialize(window, x, y, color_index = 0)
        @window = window
        @x, @y = x, y
        @color = COLORS[color_index]
    end

    def update
        unless out_of_bounds?
            @x -= 2
            @y += 4
        end
    end

    def draw
        @window.draw_line(@x, @y, @color, @x + 1, @y + 1, @color, -1)
    end

    def out_of_bounds?
        @y >= Astrosmash::WIN_HEIGHT || @x <= 0
    end
end