begin
  # load wirble
  require 'wirble'

  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

=begin
require 'bundler'
begin
  Bundler.require :console
rescue Bundler::GemfileNotFound
  require 'wirble'
  require 'hirb'
end
Wirble.init
Wirble.colorize
Hirb.enable
=end
