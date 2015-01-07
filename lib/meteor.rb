class Meteor
    TYPES  = [
        {size: 'large', value: 10}, 
        {size: 'small', value: 20}
    ]
    COLORS = [
        Gosu::Color.argb(0xFF574D95),
        Gosu::Color.argb(0xFFAC4D83),
        Gosu::Color.argb(0xFFA4C85A),
        Gosu::Color.argb(0xFFD7BE60),
        Gosu::Color.argb(0xFF3F8D77),
        Gosu::Color.argb(0xFFD78B60)
    ]

    def initialize(window)
        @window = window
        @rng = Random.new
        @type = random_type
        @image = window.load_image("asteroid_#{size}.png")
        @x, @y = start_position
        @step_y  = @rng.rand(1.0..5.0)
        @step_x  = @rng.rand(-1.5..1.5)
        @color = random_color
    end

    def update
        @y += @step_y
        @x -= @step_x
    end

    def draw
        @image.draw(@x, @y, -1, 1, 1, @color)
    end

    def out_of_bounds?
        @y >= 420 || @x <= -@image.width || @x >= @window.width
    end

    def size
        @type[:size]
    end

    def value
        @type[:value]
    end

    private

    def start_position
        [@rng.rand(0..(@window.width - @image.width)), -@image.height]
    end

    def random_type
        TYPES[@rng.rand(0..(TYPES.count - 1))]
    end

    def random_color
        COLORS[@rng.rand(0..(COLORS.count - 1))]
    end
end