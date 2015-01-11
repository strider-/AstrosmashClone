class Hud
    def initialize(window, play_state)
        @window = window
        @font = Gosu::Font.new(window, 'Courier New', 40)
        @state = play_state
        @player_icon = window.load_image('player.png')
    end

    def update; end

    def draw
        @window.fill_rect(*bounds, Gosu::Color::BLACK)
        @font.draw(score, 10, 435, 0, 1.0, 1.0)
        @font.draw(lives, 580, 435, 0, 1.0, 1.0)
        @window.draw_line(*location, Gosu::Color::GRAY, @window.width, PlayState::FLOOR, Gosu::Color::GRAY)
        @player_icon.draw(555, 436,  0, 0.5, 0.5)
    end

    private

    def location
        @location ||= [0, PlayState::FLOOR]
    end

    def bounds
        @bounds ||= [*location, @window.width, @window.height]
    end

    def score
        @state.score.to_s.rjust(6, '0')
    end

    def lives
        "x#{@state.lives.to_s.rjust(2, '0')}"
    end
end