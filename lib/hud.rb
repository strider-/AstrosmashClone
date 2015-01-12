class Hud
    WARP_READY_COLOR    = 0xFF859900
    WARP_CHARGING_COLOR = 0xFFD23D3D

    def initialize(window, play_state, player)
        @window = window
        @player = player        
        @state = play_state
        @warp_bar = ProgressBar.new(@window, 445, 441, 96, 16)
        @font = Gosu::Font.new(window, 'Courier New', 40)
        @player_icon = window.load_image('player.png')
    end

    def update
        @warp_bar.value = @player.warp_status
        @warp_bar.color_fg = warp_bar_color
    end
    
    def draw
        @window.fill_rect(*bounds, Gosu::Color::BLACK)
        @font.draw(score, 10, 435, 0, 1.0, 1.0)
        @font.draw(lives, 580, 435, 0, 1.0, 1.0)
        @window.draw_line(*location, Gosu::Color::GRAY, @window.width, PlayState::FLOOR, Gosu::Color::GRAY)
        @player_icon.draw(555, 436,  0, 0.5, 0.5)
        @warp_bar.draw
    end

    private

    def location
        @location ||= [0, PlayState::FLOOR]
    end

    def bounds
        @bounds ||= [*location, @window.width, @window.height]
    end

    def score
        @state.score.to_s.rjust(6, '0')
    end

    def lives
        "x#{@state.lives.to_s.rjust(2, '0')}"
    end

    def warp_bar_color
        @player.warp_status == 1.0 ? WARP_READY_COLOR : WARP_CHARGING_COLOR
    end
end