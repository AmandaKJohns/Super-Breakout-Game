require "forwardable"

class Block
  extend Forwardable
  attr_accessor :x, :y, :game

  def_delegators :@image, :width, :height
  def_delegators :game, :ball, :level

  def initialize(game, x, y)
    @image = Image.new('./assets/images/block3.png')
    @game = game
    @x = x
    @y = y
  end

  def render(container, graphics)
    @image.draw(@x, @y)
  end

  #second ball not hitting the blocks
  def update(container, delta)
    if  ball.x >= @x && 
        ball.x <= (@x + width) && 
        ball.y >= @y && 
        ball.y <= (@y + height)
          ball.angle_change
          @x = 800
          @y = 800
    end
  end

end