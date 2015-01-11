class Meteor
    attr_reader :step_y, :color, :hit_box

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
        Gosu::Color.argb(0xFFD78B60),
        Gosu::Color.argb(0xFF426E89)
    ]

    def self.create_small(window, large_meteor, step_x)
        Meteor.new(window, large_meteor, step_x)
    end

    def initialize(window, parent_meteor = nil, step_x = nil)
        @window  = window
        @type    = parent_meteor.nil? ? random_type : TYPES[1]
        @image   = window.load_image("asteroid_#{size}.png")
        @x, @y   = parent_meteor.nil? ? start_position : parent_meteor.position
        @hit_box = Rect.new(@x, @y, @image.width, @image.height)
        @step_y  = parent_meteor.nil? ? Gosu.random(1.0, 5.0) : parent_meteor.step_y
        @step_x  = step_x || Gosu.random(-1.5, 1.5)
        # @step_a  = Gosu.random(0, 5)
        @color   = parent_meteor.nil? ? random_color : parent_meteor.color
        # @angle   = 0
    end

    def update
        @y += @step_y
        @x -= @step_x
        # @angle += @step_a
        @hit_box.offset(-@step_x, @step_y)
    end

    def draw
        # @image.draw_rot(@x, @y, -1, @angle, 0.5, 0.5, 1, 1, @color)
        @image.draw(@x, @y, -1, 1, 1, @color)
    end

    def out_of_bounds?
        @x <= -@image.width || @x >= @window.width
    end

    def crashed?
        @y >= PlayState::FLOOR
    end    

    def size
        @type[:size]
    end

    def value
        @type[:value]
    end

    def large?
        size == 'large'
    end

    def position
        [@x, @y]
    end

    def split
        [
            Meteor.create_small(@window, self, -1.5),
            Meteor.create_small(@window, self, 1.5)
        ]
    end

    private

    def start_position
        [Gosu.random(0, (@window.width - @image.width)), -@image.height]
    end

    def random_type
        TYPES[Gosu.random(0, TYPES.count).truncate]
    end

    def random_color
        COLORS[Gosu.random(0, COLORS.count).truncate]
    end
end