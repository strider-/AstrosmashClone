#!/usr/bin/env ruby
require 'gosu'

BASE_PATH   = File.dirname(File.absolute_path(__FILE__))
MEDIA_PATH  = File.join(BASE_PATH, 'media')
SHOW_HITBOX = false

%w(
    lib/states/game_state.rb
    lib/collidable.rb
    lib/meteor.rb
    lib/large_meteor.rb
    lib/small_meteor.rb
    lib/spinner.rb
    lib/large_spinner.rb
    lib/small_spinner.rb
    lib/ufo.rb
    lib/homing_missile.rb
).each do |file|
    require "#{BASE_PATH}/#{file}"
end

Dir["#{BASE_PATH}/lib/**/*.rb"].each do |file|
    require file
end

Astrosmash.play