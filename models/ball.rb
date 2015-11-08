require "forwardable"

class Ball
  extend Forwardable
  attr_accessor :x, :y, :angle, :game, :speed

  def_delegators :@image, :width, :height
  def_delegators :game, :paddle

  ALL_BALLS = []

  def initialize(game)
    @image = Image.new('./assets/images/ball.png')
    @game = game
    reset
    ALL_BALLS << self
  end

  def render(container, graphics)
    @image.draw(@x, @y)
  end

  def self.all
    ALL_BALLS
  end

  def reset
    @x = 100
    @y = 400
    @speed = 0.4
    # @angle = 0.25
    @angle = 45
  end

  def angle_change
    change = [90,270]
    @angle = (@angle + change.sample) % 360
  end

  def update(container, delta)
    # @x += @speed * delta * Math.cos(@angle * Math::PI)
    # @y -= @speed * delta * Math.sin(@angle * Math::PI)
    @x += @speed * delta * Math.cos(@angle * Math::PI / 180)
    @y -= @speed * delta * Math.sin(@angle * Math::PI / 180)

    # if (@x >= container.width - width) || (@y <= 0) || (@x <= 0)
    #   # @angle = (@angle + 0.5) % 2
    #   angle_change
    # end
    if (@x >= container.width - width)
      @x = container.width - width
      angle_change
    elsif (@y <= 0)
      @y = 0
      angle_change
    elsif (@x <= 0)
      @x = 0
      angle_change
    end

    if @y > container.height && self.class.all.count > 1
      self.class.all.delete(self)
    elsif @y > container.height && self.class.all.count == 1
      game.reset(container)
    end

    if  ((@y + height >= paddle.y) ||
        (@y >= paddle.y + paddle.height)) &&
        @x <= paddle.x + paddle.var_width &&
        @x + width >= paddle.x
      # @angle = (@angle + 0.5 + rand(0.2) - 0.1) % 2
          @y = paddle.y - paddle.height 
          angle_change
    end

  end

end