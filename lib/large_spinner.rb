class LargeSpinner < Spinner
    def initialize(window:, speed: nil)
        super(window: window, size_factor: 1.0, speed: speed)
    end

    def value
        40
    end
end