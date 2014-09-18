require_relative 'board'
require_relative 'player'
require_relative 'piece'

class Game

  attr_accessor :board, :player1, :player2

  def initialize
    @board    = Board.new
    @player1  = Player.new(:w)
    @player2  = Player.new(:b)
    @turns    = [self.player1,self.player2].cycle
  end

  def play
    until board.won?
      board.show
      player  = @turns.next
      pcolor  = player.color
      puts "It is #{color(player.color)}'s turn"
      moves   = player.choose_move
      board.move(moves,pcolor)
    end
  end
  def color(player_color)
    player_color == :w ? "white" : "black"
  end

end