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

  describe '#choose_position' do
    subject(:choose_game) { described_class.new(player1, player2) }

    context 'when user chooses 1 and 1' do
      before do
        allow(choose_game).to receive(:puts).twice
      end

      it 'asks for two inputs' do
        expect(choose_game).to receive(:puts).twice
        choose_game.choose_position
      end

      before do
        valid = 1
        allow(choose_game).to receive(:gets).and_return(valid).twice
      end

      it 'returns [1, 1]' do
        result = choose_game.choose_position
        expect(result).to eq([1, 1])
      end
    end
  end

  describe '#place_symbol' do
    subject(:place_game) { described_class.new(player1, player2) }

    before {place_game.instance_variable_set(
      :@grid, 
      [['X',nil,'X'],
       [nil,'O','O'],
       [nil,'O','X']]) }
    
    context 'when the chosen position is empty' do
      before do
        allow(place_game).to receive(:choose_position).and_return([1, 2])
        allow(place_game).to receive(:print_grid).once
      end

      it 'the chosen board position updates its value' do
        place_game.place_symbol
        square = place_game.instance_variable_get(:@grid)
        expect(square[0][1]).not_to be_nil
      end

      it 'print_grid is called' do
        expect(place_game).to receive(:print_grid).once
        place_game.place_symbol
      end
    end

    context 'when the chosen position is already taken' do
      before do
        allow(place_game).to receive(:choose_position).and_return([1, 1], [1, 1], [2, 1])
        allow(place_game).to receive(:puts).exactly(3).times
      end

      it 'puts is called twice if taken position is given' do
        expect(place_game).to receive(:puts).with("That position is already played, please choose again.").twice
        place_game.place_symbol
      end
    end
  end
end