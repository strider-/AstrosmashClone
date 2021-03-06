class Astrosmash < Gosu::Window
    WIN_WIDTH = 640
    WIN_HEIGHT = 480

    def self.play
        new.show
    end

    def initialize
        super WIN_WIDTH, WIN_HEIGHT, false
        self.caption = "Astrosmash Clone"
        @images = {}
        @fonts  = {}
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

    def button_down(id)
        @state.button_down id
    end

    def button_up(id)
        @state.button_up id
    end    

    def state=(state)
        @state = state
    end

    def reset
        self.state = SplashState.new(self)
    end

    def player_position
        @state.player_position if @state.respond_to?(:player_position)
    end

    def fill_rect(x, y, x2, y2, color)
        draw_quad(x, y, color, x2, y, color, x, y2, color, x2, y2, color)
    end

    def load_image(name)
        @images[name] ||= Gosu::Image.new(self, File.join(MEDIA_PATH, name))
    end

    def load_tiles(name, tile_width, tile_height)
        @images[name] ||= Gosu::Image::load_tiles(self, File.join(MEDIA_PATH, name), tile_width, tile_height, true)
    end

    def load_font(name, size)
        @fonts[[name, size]] ||= Gosu::Font.new(self, File.join(MEDIA_PATH, name), size)
    end
end