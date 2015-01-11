#!/usr/bin/env ruby
require 'gosu'

BASE_PATH  = File.dirname(File.absolute_path(__FILE__))
MEDIA_PATH = File.join(BASE_PATH, 'media')

preload = %w(lib/states/game_state.rb)
preload.each do |file|
    require "#{BASE_PATH}/#{file}"
end

Dir["#{BASE_PATH}/lib/**/*.rb"].each do |file|
    require file
end

Astrosmash.play