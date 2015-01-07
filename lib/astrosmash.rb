class Astrosmash < Gosu::Window
    WIN_WIDTH = 640
    WIN_HEIGHT = 480  

    def initialize
        super WIN_WIDTH, WIN_HEIGHT, false
        self.caption = "Astrosmash Clone"
        @images = {}
        reset
    end

    def update
        @state.update

        close if button_down?(Gosu::KbEscape)
        reset if button_down?(Gosu::KbR) && !@state.is_a?(SplashState)
    end

    def draw
        @state.draw
    end

    def state=(state)
        @state = state
    end

    def reset
        self.state = SplashState.new(self)
    end

    def fill_rect(x, y, x2, y2, color)
        draw_quad(x, y, color, x2, y, color, x, y2, color, x2, y2, color)
    end

    def load_image(name)
        @images[name] ||= Gosu::Image.new(self, File.join(MEDIA_PATH, name))
    end
end