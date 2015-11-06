require "forwardable"

class Paddle
  extend Forwardable
  attr_accessor :x, :y

  def_delegators :@image, :width, :height

  def initialize(game)
    @image = Image.new('./assets/images/paddle.png')
    @game = game
    reset
  end

  def render(container, graphics)
    @image.draw(@x, 400)
  end

  def reset
    @x = 200
    @y = 400
  end

  def update(container, delta)
    input = container.get_input

    if input.is_key_down(Input::KEY_LEFT) and @x > 0
      @x -= 0.4 * delta
    end

    if input.is_key_down(Input::KEY_RIGHT) and @x < container.width - width
      @x += 0.4 * delta
    end
  end

end