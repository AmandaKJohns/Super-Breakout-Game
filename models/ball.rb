require "forwardable"

class Ball
  extend Forwardable
  attr_accessor :x, :y, :angle, :game

  def_delegators :@image, :width, :height
  def_delegators :game, :paddle

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
    # @angle = 0.25
    @angle = 45
  end

  def update(container, delta)
    # @x += 0.3 * delta * Math.cos(@angle * Math::PI)
    # @y -= 0.3 * delta * Math.sin(@angle * Math::PI)
    @x += 0.3 * delta * Math.cos(@angle * Math::PI / 180)
    @y -= 0.3 * delta * Math.sin(@angle * Math::PI / 180)

    if (@x > container.width - width) || (@y < 0) || (@x < 0)
      # @angle = (@angle + 0.5) % 2
      @angle = (@angle + 90) % 360
    end

    if @y > container.height
      game.reset
    end

    if  @y + height > paddle.y &&
        @x < paddle.x + paddle.width &&
        @x + width > paddle.x
      # @angle = (@angle + 0.5 + rand(0.2) - 0.1) % 2
      @angle = (@angle + 90) % 360
    end
  end

end