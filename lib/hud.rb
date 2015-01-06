class Hud
    def initialize(window, play_state)
        @window = window
        @font = Gosu::Font.new(window, 'Courier New', 40)
        @state = play_state
    end

    def draw
        @window.fill_rect(0, 420, @window.width, @window.height, Gosu::Color::BLACK)
        @font.draw(score, 10, 435, 0, 1.0, 1.0)
        @font.draw(lives, 595, 435, 0, 1.0, 1.0)
        @window.draw_line(0, 420, Gosu::Color::GRAY, 640, 420, Gosu::Color::GRAY)
    end

    private

    def score
        @state.score.to_s.rjust(6, '0')
    end

    def lives
        @state.lives.to_s.rjust(2, '0')
    end
end