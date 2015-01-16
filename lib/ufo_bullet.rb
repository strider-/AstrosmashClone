class UFOBullet
    include Collidable

    SPEED = 4.5

    def initialize(window:, start:, target:, ufo:)
        super(window: window, image_name: 'ufo_bullet.png')
        @parent = ufo
        set_position *start
        @dir_x, @dir_y = get_direction(target)
    end

    def update
        offset(@dir_x * SPEED, @dir_y * SPEED)
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

    private 

    def get_direction(target)
        target_x, target_y = target        
        unit_x = target_x - @x
        unit_y = target_y - @y
        len = Math.sqrt((unit_x * unit_x) + (unit_y * unit_y))        
        [unit_x / len, unit_y / len]
    end
end