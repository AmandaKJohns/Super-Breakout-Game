$:.push File.expand_path('../../lib', __FILE__)

require 'java'
require 'lwjgl.jar'
require 'slick.jar'
require 'forwardable'

java_import org.newdawn.slick.BasicGame
java_import org.newdawn.slick.GameContainer
java_import org.newdawn.slick.Graphics
java_import org.newdawn.slick.Image
java_import org.newdawn.slick.Input
java_import org.newdawn.slick.SlickException
java_import org.newdawn.slick.AppGameContainer
