class Star
    COLORS = [
        Gosu::Color::GRAY,
        Gosu::Color::BLUE,
        Gosu::Color::GREEN,
        Gosu::Color::YELLOW
    ]

    def initialize(window)
        @window = window
        @x, @y = random_position
        @color = COLORS[random_index]
    end

    def update
        @x -= 2
        @y += 4
    end

    def draw
        @window.draw_line(@x, @y, @color, @x + 1, @y + 1, @color, -1)
    end

    def out_of_bounds?
        @y >= @window.height || @x <= 0
    end

    private

    def random_position
        [Gosu.random(0, 800), Gosu.random(0, 300) * -1]
    end

    def random_index
        Gosu.random(0, COLORS.count).truncate
    end
end