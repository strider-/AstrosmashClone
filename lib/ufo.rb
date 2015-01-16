class UFO < Meteor
    attr_reader :bullets

    MOVE_STEP     = 2.5
    FIRE_INTERVAL = 450

    def initialize(window: window, speed: nil)
        super(window: window, image_name: 'ufo.png')
        @step_y  = 0
        @step_x  = MOVE_STEP
        @color   = Gosu::Color::WHITE
        @bullets = []
        @last_shot = Gosu.milliseconds        
    end

    def out_of_bounds?
        x <= -image.width
    end

    def update
        unless dead?
            super            
            fire if should_fire?
        end
        @bullets.each(&:update).reject!(&:out_of_bounds?)
    end

    def draw
        super unless dead?
        @bullets.each(&:draw)
    end

    def crashed?
        false
    end

    def out_of_play?
        (out_of_bounds? || dead?) && @bullets.empty?
    end

    def size
        'ufo'
    end

    def value
        100
    end

    def clear_bullet(bullet)
        @bullets.delete(bullet)
    end

    private

    def should_fire?
        (Gosu.milliseconds - @last_shot) > FIRE_INTERVAL
    end

    def fire
        @bullets.push UFOBullet.new(window: window, start: bullet_start, target: bullet_target, ufo: self)
        @last_shot = Gosu.milliseconds
    end

    def start_position
        [window.width, 20]
    end

    def bullet_start
        [x + (image.width / 2), y + image.height]
    end

    def bullet_target
        [window.width - x, PlayState::FLOOR]
    end
end