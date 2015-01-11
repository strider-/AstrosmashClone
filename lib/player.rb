class Player
    attr_reader :bullets, :hit_box

    SHOT_DELAY = 250
    MOVE_STEP  = 5

    def initialize(window)
        @window = window
        @image = window.load_image('player.png')
        @x, @y = start_position
        @hit_box = Rect.new(@x, @y, @image.width, @image.height)
        @right_most = @window.width - @image.width
        @bullets = []
        @last_shot = 0
    end

    def update
        handle_input
        update_bullets
    end 

    def draw
        @image.draw(@x, @y, 0)
        @bullets.each(&:draw)
    end

    def move_left
        @x = [@x - MOVE_STEP, 0].max
        @hit_box.move_to(@x, @hit_box.y)
    end

    def move_right
        @x = [@x + MOVE_STEP, @right_most].min
        @hit_box.move_to(@x, @hit_box.y)
    end

    def fire
        @bullets.push(Bullet.new(@window, barrel_position))
        @last_shot = Gosu.milliseconds
    end

    def clear_bullet(bullet)
        @bullets.delete(bullet)
    end

    def reset
        @x, @y = start_position
        @bullets.clear
    end

    private

    def handle_input
        move_left  if @window.button_down?(Gosu::KbLeft)
        move_right if @window.button_down?(Gosu::KbRight)
        fire       if @window.button_down?(Gosu::KbSpace) && can_fire?
    end

    def update_bullets        
        @bullets.each(&:update)
        @bullets.reject! do |bullet|
            bullet.out_of_bounds?
        end
    end

    def barrel_position
        [@x + 17, ship_top]
    end

    def can_fire?
        time_since_last_shot >= SHOT_DELAY
    end

    def time_since_last_shot
        Gosu.milliseconds - @last_shot
    end

    def start_position
        [(@window.width / 2) - (@image.width / 2), ship_top]
    end

    def ship_top
        PlayState::FLOOR - @image.height
    end
end