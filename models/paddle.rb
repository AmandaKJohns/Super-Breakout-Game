require "forwardable"

class Paddle
  extend Forwardable
  attr_accessor :x, :y, :speed, :key_left, :key_right, :var_width

  def_delegators :@image, :width, :height

  def initialize(game)
    @image = Image.new('./assets/images/paddle.png')
    @game = game
    @x = 200
    @var_width = width
    reset
  end

  def render(container, graphics)
    @image.draw(@x, 400, var_width, height)
  end

  def reset
    @var_width = width
    @speed = 0.4
    @y = 400
    @key_left = Input::KEY_LEFT
    @key_right = Input::KEY_RIGHT
  end

  def update(container, delta)
    input = container.get_input

    if input.is_key_down(key_left) and @x > 0
      @x -= speed * delta
    end

    if input.is_key_down(key_right) and @x < container.width - width
      @x += speed * delta
    end
    
  end

end