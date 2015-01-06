class Starfall
    MAX_STARS = 50

    def initialize(window)
        @window = window
        @stars = []
        @active = true
        @rng = Random.new
    end

    def update
        if @active
            @stars.each(&:update)
            @stars.reject! do |star|
                star.out_of_bounds?
            end
            ensure_min_stars
        end
    end

    def draw
        if @active
            @stars.each(&:draw)
        end
    end

    def destroy
        @active = false
        @stars = nil
    end

    private

    def ensure_min_stars
        [(MAX_STARS - @stars.count), 5].min.times do |i|
            @stars.push new_star
        end
    end

    def new_star
        x = @rng.rand(0..800)
        y = @rng.rand(0..300) * -1
        c = @rng.rand(0..3)
        Star.new(@window, x, y, c)
    end
end