class Player
    include Collidable

    SHOT_DELAY = 250
    MOVE_STEP  = 6.5
    WARP_DELAY = 3000

    def initialize(window)
        super(window: window, image_name: 'player.png')
        set_hit_box(x + 5, y + 5, image.width - 10, image.height - 5)
        @right_most = window.width - image.width
        @bullets = []
        @last_shot = 0
        @last_warp = -WARP_DELAY
    end

    def update
        handle_input
        update_bullets
    end

    def draw
        image.draw(*position, 0)
        @bullets.each(&:draw)
        draw_hit_box
    end

    def move_left
        self.x = [self.x - MOVE_STEP, 0].max
    end

    def move_right
        self.x = [self.x + MOVE_STEP, @right_most].min
    end

    def fire
        if can_fire?
            @bullets.push(Bullet.new(window: window, start_position: barrel_position))
            @last_shot = Gosu.milliseconds
        end
    end

    def reset
        self.x, self.y = start_position
        @bullets.clear
        @last_shot = 0
        @last_warp = -WARP_DELAY
    end

    def warp
        if can_warp?
            self.x = Gosu.random(0, @right_most).truncate
            @last_warp = Gosu.milliseconds
        end
    end

    def button_down(id)
        warp if id == Gosu::KbLeftShift
    end

    def warp_status
        [time_since_last_warp.to_f / WARP_DELAY.to_f, 1.0].min
    end

    def hit_box_color
        Gosu::Color.argb(0x7A7A7AFF)
    end

    def shot_down?(meteor)
        @bullets.any? do |bullet|
            bullet.collides_with?(meteor)
        end
    end

    private

    def handle_input
        move_left  if button_down?(Gosu::KbLeft)
        move_right if button_down?(Gosu::KbRight)
        fire       if button_down?(Gosu::KbSpace)
    end

    def move_hit_box(x, y)
        hit_box.move_to(x + 5, hit_box.y)
    end

    def update_bullets
        @bullets.each(&:update)
        @bullets.reject! do |bullet|
            bullet.out_of_bounds?
        end
    end

    def barrel_position
        [x + 17, ship_top]
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
        [(window.width / 2) - (image.width / 2), ship_top]
    end

    def ship_top
        PlayState::FLOOR - image.height
    end
end