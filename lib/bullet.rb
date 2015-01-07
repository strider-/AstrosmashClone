class Bullet
    MOVE_STEP = 5

    def initialize(window, x)
        @window = window
        @image = window.load_image('bullet.png')
        @x, @y = x + 17, 374
    end

    def update
        @y -= MOVE_STEP
    end

    def draw
        @image.draw(@x, @y, 0)
    end

    def out_of_bounds?
        @y < -@image.height
    end
end