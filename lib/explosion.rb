class Explosion
    def initialize(window, x, y)
        @x, @y = x, y
        @tiles = window.load_tiles('explode.png', 28, 28)
        @img = @tiles[0]
        @done = false
        @play_count = 0
        @start_time = Gosu::milliseconds
    end

    def update
        unless done?
            idx = current_index
            @img = @tiles[idx] 
            @play_count += 1 if idx == 0
        end
    end

    def draw
        @img.draw(@x, @y, -1) unless done?
    end

    def done?
        @play_count >= 2
    end

    private

    def current_index
        ((@start_time - Gosu::milliseconds) / 50) % @tiles.size
    end
end