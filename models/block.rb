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
    Ball.all.each do |ball|
      if  ball.x + ball.width >= @x && 
          ball.x <= (@x + width) && 
          ball.y + ball.height >= @y && 
          ball.y <= (@y + height)
            ball.angle_change
            @x = 800
            @y = 800
      end
    end
  end

end