class PongGame < BasicGame

 def render(container, graphics)
   @bg.draw(0, 0)
   @ball.draw(@ball_x, @ball_y)
   @paddle.draw(@paddle_x, 400)
   @block.draw(@block_x, @block_y)
   graphics.draw_string('RubyPong (ESC to exit)', 8, container.height - 30)
 end

 def init(container)
   @bg = Image.new('rsz_galaxy.png')
   @ball = Image.new('ball.png')
   @paddle = Image.new('paddle.png')
   @block = Image.new('block.png')
   @paddle_x = 200
   @ball_x = 200
   @ball_y = 200
   @ball_angle = 45
   @block_x = 200
   @block_y = 100
 end

 def update(container, delta)
   input = container.get_input
   container.exit if input.is_key_down(Input::KEY_ESCAPE)

   if input.is_key_down(Input::KEY_LEFT) and @paddle_x > 0
     @paddle_x -= 0.5 * delta
   end

   if input.is_key_down(Input::KEY_RIGHT) and @paddle_x < container.width - @paddle.width
     @paddle_x += 0.5 * delta
   end

   @ball_x += 0.3 * delta * Math.cos(@ball_angle * Math::PI / 180)
   @ball_y -= 0.3 * delta * Math.sin(@ball_angle * Math::PI / 180)

   if (@ball_x > container.width - @ball.width) || (@ball_y < 0) || (@ball_x < 0)
     @ball_angle = (@ball_angle + 90) % 360
   end

   if @ball_y > container.height
     @paddle_x = 200
     @ball_x = 200
     @ball_y = 200
     @ball_angle = 45
   end

   if @ball_x >= @paddle_x && @ball_x <= (@paddle_x + @paddle.width) && @ball_y.round >= (400 - @ball.height)
     @ball_angle = (@ball_angle + 90) % 360
   end

   if @ball_x >= @block_x && @ball_x <= (@block_x + @block.width) && @ball_y >= @block_y && @ball_y <= (@block_y + @block.height)
     @ball_angle = (@ball_angle + 90) % 360
     @block_x = 800
     @block_y = 800
   end

 end

end