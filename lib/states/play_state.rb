class PlayState < GameState
    attr_reader :lives, :score

    FLOOR = 420 # smoke games every day

    def initialize(window)
        super window
        @hud = Hud.new(window, self)
        @meteor_shower = MeteorShower.new(window)
        @player = Player.new(window)        
        @bg_color = Gosu::Color.rgba(0x55555555)
        @lives = 3
        @score = 0
    end

    def update
        game_objects.each(&:update)
        collision_check
    end

    def draw
        @window.fill_rect(0, 0, @window.width, FLOOR, @bg_color)
        game_objects.each(&:draw)
    end

    private

    def collision_check
        meteor_hits.each do |hit|
            @meteor_shower.clear_meteor hit[:meteor]
            @player.clear_bullet hit[:bullet]
            @score += hit[:meteor].value
        end

        @score = [@score - @meteor_shower.crashed_meteor_value, 0].max
    end

    def player_was_hit?
        @meteor_shower.meteors.any? do |meteor|
            @player.hit_box.intersects_with? meteor.hit_box
        end
    end

    def meteor_hits
        hits = []
        @meteor_shower.meteors.each do |meteor|
            @player.bullets.each do |bullet|
                hits.push({ meteor: meteor, bullet: bullet }) if meteor.hit_box.intersects_with?(bullet.hurt_box)
            end
        end
        hits        
    end

    def game_objects
        @game_objects ||= [@hud, @player, @meteor_shower]
    end
end