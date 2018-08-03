# These tests will drive the development of a # two person subject game that is played using 
# the command line.
require "rspec"
require "../lib/piece.rb"
require "../lib/board.rb"
require "../lib/chess.rb"

RSpec.describe Piece do
    describe "move" do
        context "when a peice is moved to a different space" do
            subject { described_class.new("pawn", "white",'♙') }
            it "should incriment <num_move> by 1" do
                subject.move
                expect(subject.num_moves).to eq 1
            end
        end
    end

    describe "#get_black_pieces" do
        context "when looking at all the pieces a player still has" do
            it "should return the array of pieces" do
                new_game = Chess.new
                new_game.build_board
                new_game.build_pieces
                expect(Piece.get_black_pieces.length). to eq 16
            end
        end
    end
end