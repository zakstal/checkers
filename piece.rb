require 'colorize'

class Piece

  attr_accessor :king, :color, :pos, :board

  DELTAS = [
      [-1,-1],
      [-1, 1],
      [ 1,-1],
      [ 1, 1]
    ]

  def initialize(pos, color, board)
    @king   = false
    @board  = board
    @pos    = pos
    @color  = (color == "○" ? "○" : "●")
    @delta  = (color == "○" ? DELTAS.last(2) : DELTAS.first(2) )
  end

  def promote
    self.king = true if self.pos == 7 && self.color == "○"
    self.king = true if self.pos == 0 && self.color == "●"
    self.color.colorize(:yello)
    @delta = DELTAS
  end

  def on_board?(pos)
    pos.all? { |n| n.between?(0, 7) }
  end


  def grow_moves(multi)
    moves = []

    @delta.each do |delta|
      temp = [pos]

      multi.times do |i|
        dy,dx = delta
        sy,sx = temp.last

        move = [dy + sy, dx + sx]
        temp << move if on_board?(move)
      end
      moves += temp
    end
    moves.uniq.delete(self.pos)
    moves
  end
  #move to board
  def empty?(move)
    board[move].nil?
  end

  def jump_move?(goal_pos)
    moves     = grow_moves(2)
    valid     = moves.include?(goal_pos)
    # half position
    sy,sx     = self.pos
    y         = (goal_pos.first > self.pos.first ? 1 : -1)
    x         = (goal_pos.last  > self.pos.last  ? 1 : -1)
    inbetween = [y + sy, x + sx]
    captured  = !self.board[inbetween].nil? && self.board[inbetween].color != self.color

    if captured && moves.include?(goal_pos)
      self.board[inbetween] = nil
      true
    end
  end

  def step_move(goal_pos)
    moves = grow_moves(1)
    moves.include?(goal_pos)
  end

  def valid_step?(goal_pos)
   jump_move?(goal_pos) || step_move(goal_pos)
  end


  def valid_move?(goal_pos)
    return false if !on_board?(pos)
    return false if !empty?(goal_pos)
    return false if !valid_step?(goal_pos)
    true
  end

end