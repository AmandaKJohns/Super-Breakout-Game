require "forwardable"

class Block
  extend Forwardable
  attr_accessor :game, :x, :y

  def_delegators :@image, :width, :height

  def initialize(game)
    @image = Image.new('./assets/images/block.png')
    @game = game
    reset
  end

  def render(container, graphics)
    @image.draw(@x, @y)
  end

  def reset
    @x = 200
    @y = 100
  end

end