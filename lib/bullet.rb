class Bullet
    include Collidable

    MOVE_STEP = 5

    def initialize(window, start_position)
        super(window, 'bullet.png')
        self.x, self.y = start_position
    end

    def update
        offset(0, -MOVE_STEP)
    end

    def draw
        @image.draw(@x, @y, 0)
    end

    def out_of_bounds?
        @y < -@image.height
    end
end