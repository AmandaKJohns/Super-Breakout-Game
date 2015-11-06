require './models/ball'
require './models/paddle'
require './models/block'

class PongGame < BasicGame

  attr_reader :ball, :paddle

  def render(container, graphics)
    @bg.draw(0, 0)
    @ball.render(container, graphics)
    @paddle.render(container, graphics)
    # @block.render(container,graphics)
    Block.all.each {|block| block.render(container, graphics)}
    graphics.draw_string('RubyPong (ESC to exit)', 8, container.height - 30)
  end

  def init(container)
    @bg = Image.new('./assets/images/rsz_galaxy.png')
    @ball = Ball.new(self)
    @paddle = Paddle.new(self)
    # @block = Block.new(self)
    5.times do 
      Block.new(self)
    end
  end

  def update(container, delta)
    input = container.get_input
    container.exit if input.is_key_down(Input::KEY_ESCAPE)
    ball.update(container, delta)
    paddle.update(container, delta)
    # block.update(container, delta)
    Block.all.each {|block| block.update(container, delta)}

  end

  def reset
    @ball.reset
    @paddle.reset
  end

end
