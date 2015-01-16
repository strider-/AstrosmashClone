class UFOBullet
    include Collidable

    def initialize(window:, start:, target:, ufo:)
        super(window: window, image_name: 'ufo_bullet.png')
        @parent = ufo
        set_position *start
        @target_x, @target_y = target
    end

    def update
        # TODO: oh my god how do move an object from (x, y) to (x2, y2)
        # gracefully I am not good at math
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