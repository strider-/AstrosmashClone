class ProgressBar
    attr_accessor :value, :color_bg, :color_fg

    def initialize(window, x, y, w, h)
        @window = window
        @border_rect = Rect.new(x, y, w, h)
        @fill_rect   = Rect.new(x + 2, y + 2, w - 4, h - 4)
        @value = 0.0
        @color_bg = Gosu::Color.argb(0xFF7A7A7A)
        @color_fg = Gosu::Color.argb(0xFFFFFFFF)
    end

    def draw
        @window.fill_rect(*@border_rect.bounds, color_bg)
        @window.fill_rect(*filled_bar, color_fg)
    end

    private

    def filled_bar
        x, y, x2, y2 = @fill_rect.bounds
        [x, y, x + ((x2 - x) * value), y2]
    end
end