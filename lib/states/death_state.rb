class DeathState < GameState
    def initialize(window, play_state)
        super window
        @play_state = play_state
        @bg_color = Gosu::Color.argb(0x55FF5555)
        @font = Gosu::Font.new(window, 'Courier New', 80)
        @time = Gosu.milliseconds
    end

    def update
        if done?
            @play_state.reset
            @window.state = resume_state
        end
    end

    def draw
        @window.fill_rect(0, 0, @window.width, PlayState::FLOOR, @bg_color)
        @font.draw('THANKS OBAMA', 110, 180, 0, 1.0, 1.0)
        @play_state.draw_hud
    end

    def done?
        Gosu.milliseconds - @time >= 2000
    end

    private

    def resume_state
        @play_state.lives < 0 ? GameOverState.new(@window, @play_state.peak_score) : @play_state
    end
end