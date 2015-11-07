require "forwardable"

class Block
  extend Forwardable
  attr_accessor :x, :y, :game

  def_delegators :@image, :width, :height
  def_delegators :game, :ball

  X_ARRAY = [25,100,175,250,325,400,475,550]

  ALL_BLOCKS = []

  def initialize(game)
    @image = Image.new('./assets/images/block.png')
    @game = game
    reset
    ALL_BLOCKS << self
  end

  def self.all
    ALL_BLOCKS
  end

  def render(container, graphics)
    @image.draw(@x, @y)
  end

  def reset
    @x = X_ARRAY.pop
    @y = 100
  end

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