class GameState
    attr_reader :window

    def initialize(window)
        @window = window
    end

    def update; end
    def draw;   end

    def button_down(id); end
    def button_up(id);   end

    protected

    def button_down? id
        @window.button_down? id
    end

    def button_up? id
        @window.button_up? id
    end
end