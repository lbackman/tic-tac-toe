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
end