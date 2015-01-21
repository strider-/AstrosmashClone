class GameOverState < GameState
    def initialize(window, score)
        @score = score
        @font = window.load_font("./media/ARCADE.TTF", 80)
        @stars = Starfall.new(window)
    end

    def update
        @stars.update
    end

    def draw
        @font.draw('GAME OVER', 140, 60, 0, 1.0, 1.0)
        @font.draw('High Score', 140, 250, 0, 1.0, 1.0)
        @font.draw(score, 215, 315, 0, 1.0, 1.0)
        @stars.draw
    end

    private 

    def score
        @score.to_s.rjust(6, '0')
    end
end