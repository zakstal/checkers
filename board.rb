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
    moves = move.split("")
    start = moves.first(2).map(&:to_i)
    goal  = moves.last(2).map(&:to_i)

    raise "Wrong color" if !valid_player_color?(start,color)
    self[start].valid_move?(goal)
    self[start], self[goal] = self[goal], self[start]
    self[goal].promote
    self[goal].pos = goal
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

