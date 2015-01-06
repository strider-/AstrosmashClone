class PlayState < GameState
    def initialize(window)
        super window
        @font = Gosu::Font.new(window, 'Courier New', 40)
    end

    def update

    end

    def draw
        @font.draw("//TODO: Write Game", 30, 30, 0, 1.0, 1.0)
    end
end