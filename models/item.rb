require "forwardable"

class Item
  extend Forwardable
  attr_reader :state
  attr_accessor :x, :y, :game

  def_delegators :@image, :width, :height
  def_delegators :game, :paddle, :balls

  ALL_ITEMS = []

  def initialize(game)
    @image = Image.new('./assets/images/mushroom.gif')
    @game = game
    @state = true
    reset
    ALL_ITEMS << self
  end

  def render(container, graphics)
    @image.draw(@x, @y)
  end

  def self.all
    ALL_ITEMS
  end

  def self.item_generation(game)
    # random = rand(2..4)
    # sleep(random)
    Item.new(game)
  end

  def reset
    @x = rand(50..600)
    @y = 0
    @angle = 90
  end

  def update(container, delta)
    input = container.get_input
    @y += 0.1 * delta * Math.sin(@angle * Math::PI / 180)
    
    if  (@y + height >= paddle.y) && (@x <= paddle.x + paddle.var_width) && (@x + width >= paddle.x) && @state
        self.class.all.delete(self) 
        @state = false
        item = random_item_method
        game.message = format_message(item)
        # Item.item_generation(@game)
    end

    # shooter(input)

    if @y + height > paddle.y + 50
      @state = false
    end

  end

  # def shooter(input)
  #   if input.is_key_pressed(Input::KEY_SPACE)
  #     Bullet.new(@game)
  #   end
  # end


  def format_message(item)
    "Item: " + item.gsub("_", " ") + "!!!"
  end

  def random_item_method
    items = ["megaball", "bigger_ball", "smaller_ball", "paddle_speed_up", "paddle_speed_down", "ball_slow_down", "ball_speed_up", "extra_ball", "paddle_switch", "paddle_extend", "paddle_shorten"]
    # items = ["shooter"]
    item = items.sample
    self.send(item)
    item
  end

  def paddle_speed_up
    paddle.speed *= 2
  end

  def paddle_speed_down
    paddle.speed /= 2
  end

  def ball_slow_down
    balls.each {|ball| ball.speed /= 2}
  end

  def ball_speed_up
    balls.each {|ball| ball.speed *= 1.5}
  end

  def paddle_switch
    if paddle.key_left == Input::KEY_LEFT
      paddle.key_left = Input::KEY_RIGHT
      paddle.key_right = Input::KEY_LEFT
    else
      paddle.key_left = Input::KEY_LEFT
      paddle.key_right =Input::KEY_RIGHT
    end
  end

  def extra_ball
    Ball.new(game)
  end

  def paddle_extend
    if paddle.var_width <= 200
      paddle.var_width *= 1.3
    end
  end

  def paddle_shorten
    if paddle.var_width >= 70
      paddle.var_width *= 0.7
    end
  end

  def megaball
    balls.each {|ball| ball.megaball = true}
  end

  def bigger_ball
    balls.each do |ball|
      if ball.var_width <= 40
        ball.var_width *= 1.2
        ball.var_height *= 1.2
      end
    end
  end

  def smaller_ball
    balls.each do |ball|
      if ball.var_width >= 20
        ball.var_width *= 0.8
        ball.var_height *= 0.8
      end
    end
  end

  def state_reset
    #get rid of shooter
  end

end