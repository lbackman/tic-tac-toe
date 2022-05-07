# frozen_string_literal: true

class TicTacToe
  def initialize
    @grid = Array.new(3) { Array.new(3) }
    @symbol = 'X'
  end

  def place_symbol
    pos = symbol_position
    x, y = pos.first, pos.last
    @grid[x - 1][y - 1] = @symbol unless @grid[x - 1][y - 1]
    p @grid
    if win?(@grid, @symbol)
      p "#{@symbol} wins!"
      p @grid
    else
      self.change_symbol
      place_symbol
    end
  end

  private

  def change_symbol
    if @symbol == 'X'
      @symbol = 'O'
    else
      @symbol = 'X'
    end
  end

  def symbol_position
    puts "#{@symbol}, select row (1 - 3)"
    row_position = gets.to_i
    puts "#{@symbol}, select column (1 - 3)"
    column_position = gets.to_i
    [row_position, column_position]
  end

  def diagonal_win?(board, sym)
    board.each_index.all? do |i| 
      sym == board[i][i] || sym == board[i][2-i]
    end
  end

  def row_win?(board, sym)
    board.each.any? do |row|
      row.each.all? { |value| sym == value }
    end
  end

  def win?(board, sym)
    diagonal_win?(@grid, sym) ||
    row_win?(@grid, sym) ||
    # Checks columns
    row_win?(@grid.transpose, sym)
  end

  def grid_full?(board)
    board.each.none? { |value| value == nil }
  end
end

puts 'Type "play" to begin a game'
input = gets.chomp
game = TicTacToe.new if input.downcase == 'play'
game.place_symbol
