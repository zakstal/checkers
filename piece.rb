
class Piece

  attr_accessor :king, :color, :pos, :board

  DELTAS = [
      [-1,-1],
      [-1, 1],
      [ 1,-1],
      [ 1, 1]
    ]

  def initialize(pos, color,board)
    @king   = false
    @board  = board
    @pos    = pos
    @color  = (color == :w ? :w : :b)
    @delta  = (color == :w ? DELTAS.last(2) : DELTAS.first(2) )
  end

  def promote(pos)
    self.King = true if pos[y] == 7 && self.color == :w
    self.King = true if pos[y] == 0 && self.color == :b
    @delta = DELTAS
  end

  # def forward?(goal_pos)
#     # white moves up the board or  -1
#     # black moves down the board or 1
#     new_pos = (color == :w ? pos[0] - 1 : pos[0] + 1)
#
#     y, x = forward_move
#     raise "Worng direction" if (y + new_pos) >= (goal_pos)
#     true
#   end
  def on_board?(pos)
    pos.all?{|n| n.between?(0,7)}
  end


  def grow_moves(times)
    moves = []
    @delta.each do |delta|
      temp = [pos]
      times.times do |i|
        dy,dx = delta
        sy,sx = temp.last

        move = [dy + sy, dx + sx]
        temp << move if on_board?(move)
      end
      moves << temp
    end
    moves.flatten(1).uniq
  end

  def empty?(move)
    board[move].nil?
  end

  def jump_move(goal_pos)
    moves     = grow_moves(2)
    valid     = moves.include?(goal_pos)
    py,px     = self.pos
    gy,gx     = goal_pos
    inbetween = [py + gy, px + gx]
    valid     = !self.board[inbetween].nil? && moves.includ?(goal_pos)
    raise "Yout cant move there" if !valid
  end

  def step_move(goal_pos)
    moves = grow_moves(2)
    moves.include?(goal_pos)
  end


  def valid_move?(goal_pos)
    raise "That space is off the board" if !on_board?(pos)
    raise "That space is occupoied" if !empty?(goal_pos)




  end

end