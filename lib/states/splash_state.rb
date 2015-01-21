class SplashState < GameState
    START_DELAY = 2000

    def initialize(window)
        super window
        @stars = Starfall.new(window)
        @title_font = window.load_font("./media/ARCADE.TTF", 75)
        @prompt_font = window.load_font("./media/ARCADE.TTF", 40)
        @counter = 0
        @flash_interval = 1000
        @ready = false
        @start_time = 0
    end

    def update
        @counter = (Gosu.milliseconds / @flash_interval) % 2
        @stars.update

        unless about_to_play?
            get_ready_to_play if window.button_down?(Gosu::KbSpace)
        end
    end

    def draw
        @title_font.draw('Astrosmash Clone', 40, 60, 0, 1.0, 1.0)
        @prompt_font.draw(prompt, 205, 400, 0, 1.0, 1.0) if draw_prompt?
        @stars.draw
    end

    protected

    def draw_prompt?
        @counter == 0
    end

    def prompt
        unless @ready
            'Press Space!'
        else
            ' Get Ready! '
        end
    end

    def get_ready_to_play
        @ready = true
        @start_time = Gosu.milliseconds
        @flash_interval = 250
    end

    def about_to_play?
        if @ready && @start_time + START_DELAY <= Gosu.milliseconds
            window.state = PlayState.new(window)
        end

        @ready
    end
end