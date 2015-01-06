class PlayState < GameState
    attr_reader :lives, :score

    def initialize(window)
        super window
        @hud = Hud.new(window, self)
        @bg_color = Gosu::Color.rgba(0x55555555)
        @lives = 3
        @score = 0
    end

    def update

    end

    def draw
        @window.fill_rect(0, 0, 640, 420, @bg_color)
        @hud.draw
    end
end