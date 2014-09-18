class Player

  attr_accessor :color

  def initialize(color)
    @color = color
  end

  def choose_move
    gets.chomp
  end
end