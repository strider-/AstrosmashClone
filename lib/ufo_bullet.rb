class UFOBullet
    include Collidable

    SPEED = 8.5

    def initialize(window:, start:, target:, ufo:)
        super(window: window, image_name: 'ufo_bullet.png')
        @parent = ufo
        set_position *start
        @vx, @vy = vector_to_target_position(target)
    end

    def update
        offset(@vx * SPEED, @vy * SPEED)
    end

    def draw
        image.draw(@x, @y, -1)
    end

    def out_of_bounds?
        @x <= -image.width || @x > window.width || @y >= PlayState::FLOOR
    end

    def was_shot_down!
        @parent.clear_bullet(self)
    end
end