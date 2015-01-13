class LargeSpinner < Spinner
    def initialize(window)
        super(window, 1.0)
    end

    def value
        40
    end
end