require './models/ball'
require './models/paddle'
require './models/block'
require './models/item'
require './models/bullet'
require './models/level'


class PongGame < BasicGame

  attr_reader :paddle, :lives, :level, :balls
  attr_accessor :message

  def render(container, graphics)
    @bg.draw(0, 0)
    @paddle.render(container, graphics)
    blocks.each {|block| block.render(container, graphics)}
    Ball.all.each {|ball| ball.render(container, graphics)}
    Item.all.each {|item| item.render(container, graphics)}
    Bullet.all.each {|bullet| bullet.render(container, graphics)}
    graphics.draw_string('RubyPong (ESC to exit)', 8, container.height - 30)
    graphics.draw_string("Lives: #{self.lives}", 550, container.height - 30)
    graphics.draw_string("#{message}", 400, container.height - 470)
  end

  def init(container)
    @bg = Image.new('./assets/images/rsz_galaxy.png')
    # Ball.new(self)
    @paddle = Paddle.new(self)
    @level = Level.new(self)
    @lives = 3
    @delta = 0
    @item = Item.new(self) # adding item here so it doesnt lag later when first item is generated
    @item.x = 800
  end

  def update(container, delta)
    input = container.get_input
    container.exit if input.is_key_down(Input::KEY_ESCAPE)
    balls.each {|ball| ball.update(container, delta)}
    paddle.update(container, delta)
    Bullet.all.each {|bullet| bullet.update(container, delta)}
    items.each  {|item| item.update(container, delta)}
    blocks.each {|block| block.update(container, delta)}
    # if delta.to_i % 18 == 0
    #   Item.new(self)
    # end
    if input.is_key_pressed(Input::KEY_SPACE)
      Bullet.new(self)
    end
    @delta = @delta + delta
    if @delta >= 7000
      Item.new(self)
      @delta = 0
    end

    if blocks.empty?
      you_won(container)
    end

  end

  def reset(container)
    @lives -= 1
    if @lives == 0
      game_over(container)
    end
    Ball.new(self)
    self.message = ""
    @paddle.reset
  end

  def blocks
    @level.blocks
  end

  def balls
    Ball.all
  end

  def items
    Item.all
  end

  def game_over(container)
    JOptionPane.show_message_dialog(nil, "Game Over!")
    container.exit
  end

  def you_won(container)
    JOptionPane.show_message_dialog(nil, "You Won!")
    container.exit
  end

end
