require_relative 'board'
require_relative 'player'
require_relative 'piece'
require_relative 'game_extras'
require          'colorize'

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
      moves   = split_player_answer(moves)
      board.move(moves,player.color)
      # board.multi_jump(moves, player.color) #if jump_move?(moves)
    rescue CheckersError => e
    rescue RuntimeError  => e
      puts "#{e}"
      retry
    end
  end

  def split_player_answer(move)
      moves = move.split("").map(&:to_i)
      start = moves.first(2)
      goal  = moves.last(2)
      [start,goal]
  end

end

class CheckersError < StandardError
end