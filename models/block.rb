require "forwardable"

class Block
  extend Forwardable
  attr_accessor :x, :y, :game

  def_delegators :@image, :width, :height
  def_delegators :game, :level

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
      if  ball.x + ball.var_width >= @x && 
          ball.x <= (@x + width) && 
          ball.y + ball.var_height >= @y && 
          ball.y <= (@y + height)
          if !ball.megaball
            ball.angle_change
          end
            level.blocks.delete(self)
      end
    end

  end

end