# frozen_string_literal: true

class TicTacToe
  def initialize
    @grid = Array.new(3) { Array.new(3) }
    @symbol = 'X'
  end

  def play
    place_symbol
    if win?(@grid, @symbol)
      p "#{@symbol} wins!"
      print_grid
    elsif grid_full?
      p 'Draw!'
    else
      self.change_symbol
      play
    end
  end

  private

  def place_symbol
    pos = choose_position
    x, y = pos.first, pos.last
    if @grid[x - 1][y - 1]
      p "That position is already played, please choose again."
      place_symbol
    else 
      @grid[x - 1][y - 1] = @symbol
      print_grid
    end
  end

  def change_symbol
    if @symbol == 'X'
      @symbol = 'O'
    else
      @symbol = 'X'
    end
  end

  def choose_position
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

  def print_grid
    a = @grid.flatten.map { |e| e ? e : ' '}
    puts " \n#{a[0]}|#{a[1]}|#{a[2]}\n#{a[3]}|#{a[4]}|#{a[5]}\n"\
         "#{a[6]}|#{a[7]}|#{a[8]}\n "
  end

  def grid_full?
    @grid.flatten.none?(&:nil?)
  end
end

def start_game
  puts 'Type "play" to begin a game'
  input = gets.chomp
  if input.downcase == 'play'
    game = TicTacToe.new
    game.play
    start_game
  else
    puts "Exit"
  end
end

start_game
