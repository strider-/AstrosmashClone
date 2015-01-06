#!/home/mtighe/.rubies/ruby-2.1.2/bin/ruby -w
require 'gosu'

BASE_PATH = File.dirname(File.absolute_path(__FILE__))

preload = %w(lib/states/game_state.rb)
preload.each do |file|
    require "#{BASE_PATH}/#{file}"
end

Dir["#{BASE_PATH}/lib/**/*.rb"].each do |file|
    require file
end

Astrosmash.new.show