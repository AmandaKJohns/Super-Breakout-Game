require "forwardable"

class Block
  extend Forwardable
  attr_accessor :x, :y, :game

  def_delegators :@image, :width, :height
  def_delegators :game, :ball

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

    def update(container, delta)
    if  ball.x >= @x && 
        ball.x <= (@x + width) && 
        ball.y >= @y && 
        ball.y <= (@y + height)
          ball.angle = (ball.angle + 90) % 360
          @x = 800
          @y = 800
    end

  end

end