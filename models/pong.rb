require './models/ball'
require './models/paddle'
require './models/block'
require './models/item'
require './models/bullet'

class PongGame < BasicGame

  attr_reader :ball, :paddle, :lives, :item
  attr_accessor :message

  def render(container, graphics)
    @bg.draw(0, 0)
    # @ball.render(container, graphics)
    Ball.all.each {|ball| ball.render(container, graphics)}
    @paddle.render(container, graphics)
    # @item.render(container, graphics)
    Item.all.each {|item| item.render(container, graphics)}
    # @block.render(container,graphics)
    Block.all.each {|block| block.render(container, graphics)}
    Bullet.all.each {|bullet| bullet.render(container, graphics)}
    graphics.draw_string('RubyPong (ESC to exit)', 8, container.height - 30)
    graphics.draw_string("Lives: #{self.lives}", 550, container.height - 30)
    graphics.draw_string("#{message}", 400, container.height - 470)
  end

  def init(container)
    @bg = Image.new('./assets/images/rsz_galaxy.png')
    @ball = Ball.new(self)
    @paddle = Paddle.new(self)
    @item = Item.new(self)
    # @block = Block.new(self)
    8.times do 
      Block.new(self)
    end
    @lives = 3
  end

  def update(container, delta)
    input = container.get_input
    container.exit if input.is_key_down(Input::KEY_ESCAPE)
    # ball.update(container, delta)
    Ball.all.each {|ball| ball.update(container, delta)}
    paddle.update(container, delta)
    Bullet.all.each {|bullet| bullet.update(container, delta)}
    # @item.update(container, delta)
    Item.all.each  {|item| item.update(container, delta)}
    # block.update(container, delta)
    Block.all.each {|block| block.update(container, delta)}
  end

  def reset
    @lives -= 1
    if @lives == 0
      game_over
    end
    @ball.reset
    @paddle.reset
  end

  def blocks
    Block.all
  end

  def game_over
    JOptionPane.show_message_dialog(nil, "Game Over")
    container.exit
  end

end
