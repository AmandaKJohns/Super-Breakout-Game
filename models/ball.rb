require "forwardable"

class Ball
  extend Forwardable
  attr_accessor :game, :x, :y, :angle

  def_delegators :@image, :width, :height

  def initialize(game)
    @image = Image.new('./assets/images/ball.png')
    @game = game
    reset
  end

  def render(container, graphics)
    @image.draw(@x, @y)
  end

  def reset
    @x = 200
    @y = 200
    @angle = 45
  end

end