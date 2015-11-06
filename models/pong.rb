require './models/ball'
require './models/paddle'
require './models/block'

class PongGame < BasicGame

 def render(container, graphics)
   @bg.draw(0, 0)
   @ball.render(container, graphics)
   @paddle.render(container, graphics)
   @block.render(container,graphics)
   graphics.draw_string('RubyPong (ESC to exit)', 8, container.height - 30)
 end

 def init(container)
   @bg = Image.new('./assets/images/rsz_galaxy.png')
   @ball = Ball.new(self)
   @paddle = Paddle.new(self)
   @block = Block.new(self)
 end

 def update(container, delta)
   input = container.get_input
   container.exit if input.is_key_down(Input::KEY_ESCAPE)

   if input.is_key_down(Input::KEY_LEFT) and @paddle.x > 0
     @paddle.x -= 0.5 * delta
   end

   if input.is_key_down(Input::KEY_RIGHT) and @paddle.x < container.width - @paddle.width
     @paddle.x += 0.5 * delta
   end

   @ball.x += 0.3 * delta * Math.cos(@ball.angle * Math::PI / 180)
   @ball.y -= 0.3 * delta * Math.sin(@ball.angle * Math::PI / 180)

   if (@ball.x > container.width - @ball.width) || (@ball.y < 0) || (@ball.x < 0)
     @ball.angle = (@ball.angle + 90) % 360
   end

   if @ball.y > container.height
     @paddle.x = 200
     @ball.x = 200
     @ball.y = 200
     @ball.angle = 45
   end

   if @ball.x >= @paddle.x && @ball.x <= (@paddle.x + @paddle.width) && @ball.y.round >= (400 - @ball.height)
     @ball.angle = (@ball.angle + 90) % 360
   end

   if @ball.x >= @block.x && @ball.x <= (@block.x + @block.width) && @ball.y >= @block.y && @ball.y <= (@block.y + @block.height)
     @ball.angle = (@ball.angle + 90) % 360
     @block.x = 800
     @block.y = 800
   end

 end

end
