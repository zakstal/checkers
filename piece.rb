
class Piece

  attr_accessor :king, :color, :pos, :board

  def initialize(pos, color)
    @king = false
    @pos = pos
    @color = (:w ? :w : :b)
    @delta = [
      [-1,-1],
      [-1, 1],
      [ 1,-1],
      [ 1, 1]
    ]
  end

  def promote(pos)
    self.King = true if pos[y] == (pos[y] ? 0 : 7)
  end

  def forward?(goal_pos)
    new_pos = color == :w ? pos[0] - 1 : pos[0] + 1

    y, x = forward_move
    (y + new_pos) == (goal_pos)
  end

  def non_king_moves(goal_pos)

  end

  def valid_move?(goal_pos)


  end



end