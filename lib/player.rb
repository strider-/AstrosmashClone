class Player
    SHOT_DELAY = 250

    def initialize(window)
        @window = window
        @image = window.load_image('player.png')
        @x, @y = start_position
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
        @x = [@x - step, 0].max
    end

    def move_right
        @x = [@x + step, @right_most].min
    end

    def fire
        @bullets.push(Bullet.new(@window, @x))
        @last_shot = Gosu.milliseconds
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

    def can_fire?
        time_since_last_shot >= SHOT_DELAY
    end

    def time_since_last_shot
        Gosu.milliseconds - @last_shot
    end

    def step
        5
    end

    def start_position
        [(@window.width / 2) - (@image.width / 2), 374]
    end
end