require './models/ball'
require './models/paddle'
require './models/block'
require './models/item'
require './models/bullet'
require './models/level'

class PongGame < BasicGame

  attr_reader :ball, :paddle, :lives, :item, :level
  attr_accessor :message

  def render(container, graphics)
    @bg.draw(0, 0)
    @paddle.render(container, graphics)
    Ball.all.each {|ball| ball.render(container, graphics)}
    Item.all.each {|item| item.render(container, graphics)}
    blocks.each {|block| block.render(container, graphics)}
    Bullet.all.each {|bullet| bullet.render(container, graphics)}
    graphics.draw_string('RubyPong (ESC to exit)', 8, container.height - 30)
    graphics.draw_string("Lives: #{self.lives}", 550, container.height - 30)
    graphics.draw_string("#{message}", 400, container.height - 470)
  end

  def init(container)
    @bg = Image.new('./assets/images/rsz_galaxy.png')
    Ball.new(self)
    @paddle = Paddle.new(self)
    @item = Item.new(self)
    @level = Level.new(self)
    @lives = 3
  end

  def update(container, delta)
    input = container.get_input
    container.exit if input.is_key_down(Input::KEY_ESCAPE)
    Ball.all.each {|ball| ball.update(container, delta)}
    paddle.update(container, delta)
    Bullet.all.each {|bullet| bullet.update(container, delta)}
    Item.all.each  {|item| item.update(container, delta)}
    blocks.each {|block| block.update(container, delta)}
  end

  def reset(container)
    @lives -= 1
    if @lives == 0
      game_over(container)
    end
    Ball.new(self)
    @paddle.reset
  end

  def blocks
    @level.blocks
  end

  def game_over(container)
    JOptionPane.show_message_dialog(nil, "Game Over")
    container.exit
  end

end
