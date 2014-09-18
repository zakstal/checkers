require_relative 'board'
require_relative 'player'
require_relative 'piece'
require_relative 'game_extras'

class Game

  include GameExtras

  attr_accessor :board, :player1, :player2

  def initialize
    @board    = Board.new
    @player1  = Player.new("○")
    @player2  = Player.new("●")
    @turns    = [self.player1,self.player2].cycle
  end

  def play
    until board.won?
      clear_screen
      board.show
      player  = @turns.next
      puts "It is #{color(player.color)}'s turn"
      make_move(player)
    end
  end
  def color(player_color)
    player_color == "○" ? "white" : "black"
  end

  def make_move(player)
    begin
      moves   = player.choose_move
      board.move(moves,player.color)
    rescue CheckersError => e
    rescue RuntimeError => e
      puts "#{e}"
      retry
    end
  end

end

class CheckersError < StandardError
end