require "forwardable"

class Paddle
  extend Forwardable
  attr_accessor :game, :x, :y

  def_delegators :@image, :width, :height

  def initialize(game)
    @image = Image.new('./assets/images/paddle.png')
    @game = game
    reset
  end

  def render(container, graphics)
    @image.draw(@x, 400)
  end

  def reset
    @x = 200
  end

end