class PlayState < GameState
    attr_reader :lives, :score

    def initialize(window)
        super window
        @hud = Hud.new(window, self)
        @meteor_shower = MeteorShower.new(window, self)
        @player = Player.new(window)        
        @bg_color = Gosu::Color.rgba(0x55555555)
        @lives = 3
        @score = 0
    end

    def update
        game_objects.each(&:update)
        collision_check
    end

    def draw
        @window.fill_rect(0, 0, @window.width, 420, @bg_color)
        game_objects.each(&:draw)
    end

    private

    def collision_check

    end

    def game_objects
        [@hud, @player, @meteor_shower]
    end
end