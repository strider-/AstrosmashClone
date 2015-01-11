class PlayState < GameState
    attr_reader :lives, :score

    FLOOR = 420 # smoke games every day

    def initialize(window)
        super window
        @hud = Hud.new(window, self)
        @meteor_shower = MeteorShower.new(window)
        @player = Player.new(window)        
        @bg_color = Gosu::Color.rgba(0x55555555)
        @explosions = []
        @lives = 3
        @score = 0
    end

    def update
        game_objects.each(&:update)        
        @explosions.reject! do |explosion|
            explosion.done?
        end
        collision_check
    end

    def draw
        @window.fill_rect(0, 0, @window.width, FLOOR, @bg_color)
        game_objects.each(&:draw)
    end

    private

    def collision_check
        meteor_hits.each do |hit|
            handle_shot_down_meteor hit[:meteor], hit[:bullet]
        end

        @score = [@score - @meteor_shower.crashed_meteor_value, 0].max
    end

    def handle_shot_down_meteor(meteor, bullet)
        @meteor_shower.clear_meteor meteor
        @player.clear_bullet bullet
        @explosions.push(Explosion.new(@window, *meteor.position))
        @score += meteor.value
    end

    def player_was_hit?
        @meteor_shower.meteors.any? do |meteor|
            @player.hit_box.collides_with? meteor.hit_box
        end
    end

    def meteor_hits
        hits = []
        @meteor_shower.meteors.each do |meteor|
            @player.bullets.each do |bullet|
                hits.push({ meteor: meteor, bullet: bullet }) if meteor.hit_box.collides_with?(bullet.hurt_box)
            end
        end
        hits        
    end

    def game_objects
        (@game_objects ||= [@hud, @player, @meteor_shower]) + @explosions
    end
end