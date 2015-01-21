class PauseState < GameState
    def initialize(window, play_state)
        super(window)
        @play_state = play_state
        @font = window.load_font('./media/ARCADE.TTF', 80)
        @start = Gosu.milliseconds
        @flash_interval = 750
    end

    def update
        @draw_font = draw_font?
    end

    def draw        
        @play_state.draw
        window.fill_rect(0, 0, window.width, window.height, 0xA0000000)
        @font.draw('PAUSED', 200, 180, 0, 1.0, 1.0) if @draw_font
    end

    def button_down(id)
        window.state = @play_state if id == Gosu::KbP
    end

    private

    def draw_font?
        ((@start - Gosu.milliseconds) % (@flash_interval * 2)) > @flash_interval
    end
end