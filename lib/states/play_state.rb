class PlayState < GameState
    attr_reader :lives, :score, :peak_score, :multiplier

    FLOOR = 420 # smoke games every day
    EXTRA_LIFE_INTERVAL = 1000

    def initialize(window)
        super window
        @player = Player.new(window)   
        @hud = Hud.new(window, self, @player)
        @meteor_shower = MeteorShower.new(window)     
        @bg_color = Gosu::Color.argb(0x55555555)
        @explosions = []
        @lives = 2
        @score, @peak_score = 0, 0
    end

    def update
        set_multiplier
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

    def draw_hud
        @hud.draw
    end    

    def button_down(id)
        @player.button_down(id)
    end

    def reset
        @meteor_shower.clear
        @explosions.clear
        @player.reset
    end

    private 

    def collision_check
        meteor_hits.each do |hit|
            handle_shot_down_meteor hit[:meteor], hit[:bullet]
        end

        if player_was_hit?
            @lives -= 1
            @window.state = DeathState.new(@window, self)
        end

        decrement_score(@meteor_shower.crashed_meteor_value)
    end

    def handle_shot_down_meteor(meteor, bullet)
        @meteor_shower.clear_meteor meteor
        @player.clear_bullet bullet
        @explosions.push(Explosion.new(@window, *meteor.position))
        increment_score meteor.value
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

    def increment_score(value)
        @score += (value * @multiplier)
        if @peak_score < @score
            to_next_life = @peak_score % EXTRA_LIFE_INTERVAL
            @peak_score = @score
            @lives += 1 if to_next_life > @peak_score % EXTRA_LIFE_INTERVAL
        end
    end

    def decrement_score(value)
        @score = [@score - (value * @multiplier), 0].max
    end

    def game_objects
        (@game_objects ||= [@hud, @player, @meteor_shower]) + @explosions
    end

    def set_multiplier
        @multiplier = case @score
        when 0..999
            1
        when 1000..4999
            2
        when 5000..19999
            3
        when 20000..49999
            4
        when 50000..99999
            5
        else
            6
        end
    end       
end