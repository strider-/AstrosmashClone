class DeathState < GameState
    def initialize(window, play_state)
        super window
        @play_state = play_state
        @bg_color = Gosu::Color.rgba(0xFF555555)
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
        @play_state.hud.draw
    end

    def done?
        Gosu.milliseconds - @time >= 2000
    end

    private

    def resume_state
        @play_state.lives == 0 ? GameOverState.new(@window, @play_state.score) : @play_state
    end
end