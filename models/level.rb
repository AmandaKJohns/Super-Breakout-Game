require "forwardable"

class Level

  extend Forwardable
  attr_accessor :game, :blocks
  def_delegator :game, :ball

  def initialize(game)
    @game = game
    # Ball.new(game)
    block_create_one(50)
    block_create_two(75)
    block_create_one(100)
    block_create_two(125)
    block_create_one(150)
  end

  def block_create_one(y)
    x_array = [25,75,125,175,225,275,325,375,425,475,525]
    11.times do 
      x = x_array.pop
      block = Block.new(@game, x, y)
      self.blocks << block
    end
  end

  def block_create_two(y)
    x_array = [35,85,135,185,235,285,335,385,435,485,535]
    11.times do 
      x = x_array.pop
      block = Block.new(@game, x, y)
      self.blocks << block
    end
  end

  def blocks
    @blocks ||= []
  end

end