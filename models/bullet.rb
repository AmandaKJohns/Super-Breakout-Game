require "forwardable"
class Bullet
  extend Forwardable
  attr_accessor :x, :y, :game

  def_delegators :@image, :width, :height
  def_delegators :game, :paddle, :blocks

  ALL_BULLETS = []

  def initialize(game)
    @image = Image.new('./assets/images/bullet.png')
    @game = game
    reset
    ALL_BULLETS << self
  end

  def self.all
    ALL_BULLETS
  end

  def render(container, graphics)
    @image.draw(@x, @y)
  end

  def reset
    @x = paddle.x + (paddle.width / 2.4)
    @y = paddle.y - 15
    @angle = 90
  end

  def update(container, delta)
    @y -= 0.25 * delta * Math.sin(@angle * Math::PI / 180)

    hit_block
  end

  def hit_block
    game.blocks.each do |block|
      if  x >= block.x && 
          x <= (block.x + block.width) && 
          y >= block.y && 
          y <= (block.y + block.height)
            block.x = 800
            block.y = 800
            self.x = 800
            self.y = 800
      end
    end
  end


end