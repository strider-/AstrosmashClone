class Player
    attr_reader :bullets, :hit_box

    SHOT_DELAY = 250
    MOVE_STEP  = 5
    WARP_DELAY = 5000

    def initialize(window)
        @window = window
        @image = window.load_image('player.png')
        @x, @y = start_position
        @hit_box = Rect.new(@x, @y, @image.width, @image.height)
        @right_most = @window.width - @image.width
        @bullets = []
        @last_shot = 0
        @last_warp = -WARP_DELAY
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
        if can_fire?
            @bullets.push(Bullet.new(@window, barrel_position))
            @last_shot = Gosu.milliseconds
        end
    end

    def clear_bullet(bullet)
        @bullets.delete(bullet)
    end

    def reset
        @x, @y = start_position
        @hit_box.move_to(@x, @y)
        @bullets.clear
        @last_shot = 0
        @last_warp = -WARP_DELAY
    end

    def warp
        if can_warp?
            @x = Gosu.random(0, @right_most).truncate
            @hit_box.move_to(@x, @hit_box.y)
            @last_warp = Gosu.milliseconds
        end
    end

    def button_down(id)
        warp if id == Gosu::KbLeftShift
    end

    def warp_status
        [time_since_last_warp.to_f / WARP_DELAY.to_f, 1.0].min
    end

    private

    def handle_input
        move_left  if @window.button_down?(Gosu::KbLeft)
        move_right if @window.button_down?(Gosu::KbRight)
        fire       if @window.button_down?(Gosu::KbSpace)
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

    def can_warp?
        time_since_last_warp >= WARP_DELAY
    end

    def time_since_last_shot
        Gosu.milliseconds - @last_shot
    end

    def time_since_last_warp
        Gosu.milliseconds - @last_warp
    end

    def start_position
        [(@window.width / 2) - (@image.width / 2), ship_top]
    end

    def ship_top
        PlayState::FLOOR - @image.height
    end
end