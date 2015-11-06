require "forwardable"

class Paddle
  extend Forwardable
  attr_accessor :x, :y, :speed

  def_delegators :@image, :width, :height

  def initialize(game)
    @image = Image.new('./assets/images/paddle.png')
    @game = game
    @x = 200
    reset
  end

  def render(container, graphics)
    @image.draw(@x, 400)
  end

  def reset
    @speed = 0.4
    @y = 400
  end

  def update(container, delta)
    input = container.get_input

    if input.is_key_down(Input::KEY_LEFT) and @x > 0
      @x -= speed * delta
    end

    if input.is_key_down(Input::KEY_RIGHT) and @x < container.width - width
      @x += speed * delta
    end
  end

end