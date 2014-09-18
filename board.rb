require_relative 'piece'
require          'colorize'

class Board


  def initialize(populate = true)
    popluate_board(populate)
  end

  def place_piece(pos,color)
     @rows[pos] = Piece.new(color)
  end

  def fill_rows
    [:white,:black].each do |color|

      [0,2,5,7].each_with_index do |fill_row,fill_cell|
        pos = fill_row,fill_cel
          place_piece(pos,color) if fill_cell.even?
      end

      [1,6].each_with_index do |fill_row,fill_cell|
        pos = fill_row,fill_cel
         place_piece(pos,color) if !fill_cell.even?
      end

    end
  end

  def[](pos)
    y,x = pos
    @rows[y,x]
  end

  def[]=(pos)
    y,x = pos
    @rows[y,x]
  end

  def popluate_board(populate)
    @rows = Array.new(7) { Array.new(7)}
    return unless populate == true


  end

  def pieces
    @rows.flatten.compact
  end


  def render
     @rows.map.with_index do |row,row_index|
        render_tiles(row,row_index)
     end.join("\n")
  end

  def render_tiles(row,row_index)
    color = row_index.even? ? 1 : 0
    row.map.with_index do |cell,cell_index|
      (cell_index + color).even? ? "   ".colorize(:background => :white) : "   "
     end.join("")
  end

  def show
    puts render
  end



end

