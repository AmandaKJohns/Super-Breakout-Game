require "forwardable"

class Item
  extend Forwardable
  attr_accessor :x, :y, :game

  def_delegators :@image, :width, :height
  def_delegators :game, :paddle, :ball

  ALL_ITEMS = []

  def initialize(game)
    @image = Image.new('./assets/images/mushroom.gif')
    @game = game
    reset
    ALL_ITEMS << self
  end

  def render(container, graphics)
    @image.draw(@x, @y)
  end

  def self.all
    ALL_ITEMS
  end

  def item_generation
    # sleep rand(7..15)
    self.class.new(@game)
  end

  def reset
    @x = rand(50..600)
    @y = 0
    @angle = 90
  end

  def update(container, delta)
    input = container.get_input
    @y += 0.1 * delta * Math.sin(@angle * Math::PI / 180)
    shooter(input)
    if  @y + height > paddle.y &&
        @x < paddle.x + paddle.width &&
        @x + width > paddle.x
        @x = 800
        @y = 800   
        random_item_method
        # paddle_switch
        item_generation
        # extra_ball
    end

  end

  def random_item_method
    methods = ["paddle_speed_up", "paddle_speed_down", "ball_slow_down", "ball_speed_up", "extra_ball", "paddle_switch"]
    self.send(methods.sample)
  end

  def paddle_speed_up
    paddle.speed *= 2
  end

  def paddle_speed_down
    paddle.speed /= 2
  end

  def ball_slow_down
    ball.speed /= 2
  end

  def ball_speed_up
    ball.speed *= 1.5
  end

  def paddle_switch
    paddle.key_left = Input::KEY_RIGHT
    paddle.key_right = Input::KEY_LEFT
  end

  def shooter(input)
    if input.is_key_down(Input::KEY_SPACE)
      Bullet.new(@game)
    end
  end

  def extra_ball
    Ball.new(game)
  end

end