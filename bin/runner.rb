require './config/environment.rb'
require './models/pong.rb'

app = AppGameContainer.new(PongGame.new('RubyPong'))
app.set_display_mode(640, 480, false)
app.start