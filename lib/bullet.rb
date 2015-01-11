class Bullet
    attr_reader :hurt_box

    MOVE_STEP = 5

    def initialize(window, start_position)
        @window = window
        @image = window.load_image('bullet.png')
        @x, @y = start_position
        @hurt_box = Rect.new(@x, @y, @image.width, @image.height)
    end

    def update
        @y -= MOVE_STEP
        @hurt_box.offset(0, -MOVE_STEP)
    end

    def draw
        @image.draw(@x, @y, 0)
    end

    def out_of_bounds?
        @y < -@image.height
    end
end