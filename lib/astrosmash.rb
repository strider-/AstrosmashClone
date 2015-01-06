class Astrosmash < Gosu::Window
  
  WIN_WIDTH = 640
  WIN_HEIGHT = 480

  def initialize
    super WIN_WIDTH, WIN_HEIGHT, false
    self.caption = "Astrosmash Clone"
    @state = SplashState.new(self)
  end

  def update
    @state.update

    close if button_down?(Gosu::KbEscape)
  end

  def draw
    @state.draw
  end

  def state=(state)
    @state = state
  end
end