require "forwardable"

class Item
  extend Forwardable
  attr_accessor :x, :y, :game

  def_delegators :@image, :width, :height
  def_delegators :game, :paddle

  def initialize(game)
    @image = Image.new('./assets/images/mushroom.gif')
    @game = game
    reset
  end

  def render(container, graphics)
    @image.draw(@x, @y)
  end

  def reset
    @x = rand(100..500)
    @y = 200
    @angle = 90
  end

  def update(container, delta)
    @y += 0.1 * delta * Math.sin(@angle * Math::PI / 180)

    if  @y + height > paddle.y &&
        @x < paddle.x + paddle.width &&
        @x + width > paddle.x
        @x = 800
        @y = 800        
        paddle.speed = 0.8
    end

  end

end