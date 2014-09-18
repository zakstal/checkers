require_relative 'piece'
require          'colorize'

class Board

  WHITE = [
    [0, 0],
    [0, 2],
    [0, 4],
    [0, 6],

    [1, 1],
    [1, 3],
    [1, 5],
    [1, 7],

    [2, 0],
    [2, 2],
    [2, 4],
    [2, 6],
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
    setup_board(populate)
  end

  def setup_board(populate)
    @rows = Array.new(8) { Array.new(8)}

    return if populate == false
    self.fill_rows
  end

  def fill_rows
    color = [:w,:b]
    [WHITE,BLACK].each_with_index do |all_pos,index|

      all_pos.each do |pos|
        place_piece(pos,color[index])
      end
    end
  end

  def place_piece(pos,color)
    y,x = pos
     @rows[y][x] = Piece.new(pos,color,self)
  end



  def[](pos)
    y,x = pos
    @rows[y][x]
  end

  def[]=(pos,value)
    y,x = pos
    @rows[y][x] = value
  end

  def move
    moves = gets.chomp.split("")
    start = moves.first(2).map(&:to_i)
    goal = moves.last(2).map(&:to_i)

    self[start].valid_move?(goal)
  # rescue
 #    puts "Try again"
 #    retry
    self[start], self[goal] = self[goal], self[start]
  end


  def pieces
    @rows.flatten.compact
  end

  def piece_positions
    pieces.map{|piece| piece.pos}
  end


  def render
     @rows.map.with_index do |row,row_index|

        render_tiles(row,row_index)
     end.join("\n")
  end

  def render_tiles(row,row_index)
    swich = row_index.even? ? 1 : 0
    row.map.with_index do |cell,cell_index|

        render_tile(cell_index,row_index, swich)
    end.join("")
  end


  def render_tile(cell_index,row_index, swich)

    cell = (self[[row_index,cell_index]].nil? ? "   " : " #{self[[row_index,cell_index]].color} ")
    (cell_index + swich).even? ? cell.colorize(:background => :white) : cell
  end


  def show
    puts render
  end

  def out_of_bound?(goal_pos)

  end

end

