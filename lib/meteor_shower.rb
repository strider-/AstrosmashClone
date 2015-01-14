class MeteorShower
    attr_reader :meteors
    attr_accessor :difficulty

    TYPES = {
        45 => LargeMeteor,  
        50 => SmallMeteor, 
        15 => LargeSpinner, 
        10 => SmallSpinner
    }

    UFO_TYPE = { 5 => UFO }

    def initialize(window)
        @window = window
        @meteors = []
        @interval = 1000
        @last_addition = 0
        @difficulty = 1
    end

    def update
        @meteors.each(&:update)
        @spinner_crashed = @meteors.any? { |m| m.crashed? && m.spinner? }
        @crashed_meteor_values = @meteors.select { |m| m.crashed? }.map(&:value)
        @meteors.reject! do |meteor|
            meteor.crashed? || meteor.out_of_bounds?
        end
        make_it_rain
    end

    def draw
        @meteors.each(&:draw)
    end

    def clear_meteor(meteor)
        @meteors.delete(meteor)
        @meteors.push(*meteor.split) if meteor.should_split?
    end
    
    def crashed_meteor_value
        (@crashed_meteor_values.inject(:+) || 0) / 2
    end

    def clear
        @meteors.clear
    end

    def spinner_crashed?
        @spinner_crashed
    end

    def activate_ufo!
        TYPES.merge!(UFO_TYPE) unless TYPES.include?(UFO_TYPE.keys[0])
        @total_type_weight = nil
    end

    def deactivate_ufo
        TYPES.delete(UFO_TYPE.keys[0]) if TYPES.include?(UFO_TYPE.keys[0])
        @total_type_weight = nil
    end

    private

    def make_it_rain
        if time_for_more?
            @meteors.push random_meteor
            @last_addition = Gosu.milliseconds
        end
    end

    def random_meteor
        @total_type_weight ||= TYPES.inject(0) { |sum, (weight, v)| sum + weight }
        running_weight = 0
        n = rand * @total_type_weight
        TYPES.each do |weight, type|
            return type.new(window: @window) if n > running_weight && n  <= running_weight + weight
            running_weight += weight
        end
        # TYPES[Gosu.random(0, TYPES.count).truncate].new(@window)
    end  

    def time_for_more?
        time_since_last_meteor > @interval
    end

    def time_since_last_meteor
       Gosu.milliseconds - @last_addition
    end
end