class Meteor
    include Collidable

    attr_reader :step_y, :color

    TYPES  = ['large', 'small', 'spinner', 'ufo']

    COLORS = [
        Gosu::Color.argb(0xFF574D95),
        Gosu::Color.argb(0xFFAC4D83),
        Gosu::Color.argb(0xFFA4C85A),
        Gosu::Color.argb(0xFFD7BE60),
        Gosu::Color.argb(0xFF3F8D77),
        Gosu::Color.argb(0xFFD78B60),
        Gosu::Color.argb(0xFF426E89)
    ]

    def self.create_small(window, large_meteor, step_x)
        SmallMeteor.new(window, large_meteor, step_x)
    end

    def initialize(window, image_name = nil)
        super(window, image_name || "asteroid_#{size}.png")
        @step_y  = Gosu.random(1.0, 5.0)
        @step_x  = Gosu.random(-1.5, 1.5)
        @color   = random_color
    end

    def update
        offset(-@step_x, @step_y)
    end

    def draw
        @image.draw(@x, @y, -1, 1, 1, @color)
        draw_hit_box
    end

    def out_of_bounds?
        @x <= -@image.width || @x >= @window.width
    end

    def crashed?
        @y >= PlayState::FLOOR
    end

    def size;  end

    def value; end

    def should_split?
        large? && (Gosu.random(0, 100).truncate % 2 == 0)
    end

    TYPES.each do |type|
        define_method("#{type}?") do
            size == type
        end
    end

    private

    def start_position
        [Gosu.random(0, (@window.width - @image.width)), -@image.height]
    end

    def random_color
        COLORS[Gosu.random(0, COLORS.count).truncate]
    end
end