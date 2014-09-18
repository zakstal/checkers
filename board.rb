require_relative 'piece'
require          'colorize'

class Board

  WHITE = [
    [0, 1],
    [0, 3],
    [0, 5],
    [0, 7],

    [1, 0],
    [1, 2],
    [1, 4],
    [1, 6],

    [2, 1],
    [2, 3],
    [2, 5],
    [2, 7],
  ]

  BLACK = [
    [5, 0],
    [5, 2],
    [5, 4],
    [5, 6],

    [6, 1],
    [6, 3],
    [6, 5],
    [6, 7],

    [7, 0],
    [7, 2],
    [7, 4],
    [7, 6],
  ]


  def initialize(populate = true)
    @rows = Array.new(8) { Array.new(8)}

    fill_rows if populate

  end

  def move(move, color)

    start, goal  = move

    raise "That spot is empty" if self.empty?(start)
    raise "Wrong color"        if !valid_player_color?(start,color)
    raise "Wrong move "        if !self[start].valid_move?(goal)
    is_step_move   = self[start].step_move(goal)
    self[start], self[goal] = self[goal], self[start]
    self[goal].promote
    self[goal].pos = goal
    p "goal"
    p goal
    p is_step_move
    multi_jump(goal, color) if !is_step_move
  end

  def multi_jump(start, color)
    p "multi #{start}"
    any_move = any_jump(start)
    return if any_move.nil?
    any_move.each do |move|
      self.move([start, move], color)
    end
  end

  def any_jump(start)
    p "any #{start}"
    moves = self[start].grow_moves(2)
    p "here"
    if !moves.nil?
      moves.select do |move|
        p"move #{move}"
       p !self[start].step_move(move)
      end
    end
  end

  def pieces
    @rows.flatten.compact
  end

  def piece_positions
    pieces.map { |piece| piece.pos }
  end


  def show
    puts render
  end


  def [](pos)
    y,x = pos
    @rows[y][x]
  end

  def []=(pos, value)
    y,x = pos
    @rows[y][x] = value
  end

  def won?

  end

  def valid_player_color?(move, color)
     self[move].color == color
  end

  def empty?(move)
    self[move].nil?
  end

  def dup
    new_board = Board.new

    pieces.each do |piece|
      piece.class.new(piece.pos, piece.color, self)
    end

    new_board
  end


  private


  def fill_rows
    color = ["○","●"]
    [WHITE, BLACK].each_with_index do |all_pos, index|

      all_pos.each do |pos|
        place_piece(pos, color[index])
      end
    end
  end

  def place_piece(pos, color)
    self[pos] = Piece.new(pos, color, self)
  end

  def render
    @rows.map.with_index do |row, row_index|
      render_tiles(row, row_index)
    end.join("\n")
  end

  def render_tiles(row, row_index)
    swich = row_index.even? ? 1 : 0
    row.map.with_index do |cell, cell_index|
      render_tile(cell_index, row_index, swich)
    end.join("")
  end


  def render_tile(cell_index, row_index, swich)
    y = row_index.to_s.colorize(:light_white )
    x = cell_index.to_s.colorize(:light_white )

    cell = (self[[row_index,cell_index]].nil? ? "#{y} #{x}" : "#{y}#{self[[row_index,cell_index]].color}#{x}")
    (cell_index + swich).even? ? cell.colorize(:background => :white) : cell
  end

end


