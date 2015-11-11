require "forwardable"

class Ball
  extend Forwardable
  attr_accessor :x, :y, :angle, :game, :speed, :megaball, :var_width, :var_height

  def_delegators :@image, :width, :height
  def_delegators :game, :paddle

  ALL_BALLS = []

  def initialize(game)
    @image = Image.new('./assets/images/ball.png')
    @game = game
    @megaball = false
    @var_width = width
    @var_height = height
    reset
    ALL_BALLS << self
  end

  def render(container, graphics)
    @image.draw(@x, @y, var_width, var_height)
  end

  def self.all
    ALL_BALLS
  end

  def reset
    @x = 100
    @y = 400
    @var_width = width
    @var_height = height
    # @var_width = 60 # for jeffball
    # @var_height = 60 # for jeffball
    @megaball = false
    @speed = 0.4
    # @angle = 0.25
    @angle = 45
  end

  def angle_change
    change = [90,270]
    @angle = (@angle + change.sample) % 360
  end

  def update(container, delta)
    @x += @speed * delta * Math.cos(@angle * Math::PI / 180)
    @y -= @speed * delta * Math.sin(@angle * Math::PI / 180)

    # if (@x >= container.width - width) || (@y <= 0) || (@x <= 0)
    #   # @angle = (@angle + 0.5) % 2
    #   angle_change
    # end
    if @y > paddle.y + paddle.height
    elsif (@x >= container.width - var_width)
      @x = container.width - var_width
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

    if  (@y + height >= paddle.y) &&
        @x < paddle.x + paddle.var_width &&
        @x + var_width > paddle.x
          @y = paddle.y - paddle.height 
          angle_change
    end

  end

end