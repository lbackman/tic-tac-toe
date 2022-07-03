require_relative '../lib/tic_tac_toe'

describe TicTacToe do
  let(:player1) { double('player') }
  let(:player2) { double('player') }

  before do
    allow(player1).to receive(:symbol).and_return('X')
    allow(player2).to receive(:symbol).and_return('O')
  end

  describe '#diagonal_win?' do
    subject(:diagonal_game) { described_class.new(player1, player2) }

    context 'when top-to-bottom diagonal is filled with X' do
      let(:board) { [['X','O',nil],
                     ['O','X',nil],
                     ['O',nil,'X']] }

      it 'diagonal_win? should return true' do
        sym = player1.symbol
        result = diagonal_game.diagonal_win?(board, sym)
        expect(result).to eq(true)
      end
    end

    context 'when bottom-to-top diagonal is filled with O' do
      let(:board) { [['X',nil,'O'],
                     ['X','O',nil],
                     ['O',nil,'X']] }

      it 'diagonal_win? should return true' do
        sym = player2.symbol
        result = diagonal_game.diagonal_win?(board, sym)
        expect(result).to eq(true)
      end
    end

    context 'when neither of the two diagonals is filled' do
      let(:board) { [%w[X O X],
                     %w[X O O],
                     %w[O X X]] }

      it 'diagonal_win? should return false' do
        sym = player1.symbol
        result = diagonal_game.diagonal_win?(board, sym)
        expect(result).to eq(false)
      end
    end
  end

  describe '#row_win?' do
    subject(:row_game) { described_class.new(player1, player2) }

    context 'when the top row is filled with X' do
      let(:board) { [['X','X','X'],
                     ['O','O',nil],
                     ['O',nil,'X']] }

      it 'row_win? should return true' do
        sym = player1.symbol
        result = row_game.row_win?(board, sym)
        expect(result).to eq(true)
      end
    end

    context 'when no row (or column) is filled' do
      let(:board) { [['X','O','X'],
                     ['O','O',nil],
                     ['O',nil,'X']] }

      it 'row_win? should return false' do
        sym = player1.symbol
        result = row_game.row_win?(board, sym)
        expect(result).to eq(false)
      end
    end

    context 'when a column is filled' do
      let(:board) { [['X','O','X'],
                     ['X','O',nil],
                     ['X',nil,'O']] }

      it 'row_win? should return true when board is transposed' do
        sym = player1.symbol
        board_transpose = board.transpose
        result = row_game.row_win?(board_transpose, sym)
        expect(result).to eq(true)
      end
    end
  end

  describe '#grid_full?' do
    subject(:full_game) { described_class.new(player1, player2) }

    context 'when the grid is full' do

      before {full_game.instance_variable_set(
        :@grid, 
        [%w[X O X],
         %w[X O O],
         %w[O X X]]) }

      it 'grid_full? should return true' do
        result = full_game.grid_full?
        expect(result).to eq(true)
      end
    end

    context 'when the grid is not full' do

      before {full_game.instance_variable_set(
        :@grid, 
        [['X',nil,'X'],
         [nil,'O','O'],
         [nil,'O','X']]) }

      it 'grid_full? should return false' do
        result = full_game.grid_full?
        expect(result).to eq(false)
      end
    end
  end
end