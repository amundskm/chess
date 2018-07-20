# These tests will drive the development of a # two person chess game that is played using 
# the command line.
require 'rspec'
require '../lib/chess.rb'

# "when a new Spaces object is created it should have a name,
# coordinates, and a peice" 

RSpec.describe Board do
#   build_board
    describe "#build_board" do
        context "when building board" do
            subject {described_class.new()}
            it "should create a board 8 X 8 with 64 objects, one for each space on the board." do
                subject.build_board
                expect(subject.spaces.length).to eq 64
            end

            it "each space should have a name" do
                subject.build_board
                name = subject.spaces[0].name
                expect(name).to eq "A1"
            end
        end
    end

#   draw_board
    describe "#draw_board" do
        context "when drawing board" do
            subject {described_class.new()}
            #test that the board is drawn and looks correct
        end
    end

end
                



#   get_input

#    pawn_move
#    rook_move
#    bishop_move
#    knight_move
#    king_move
#    queen_move

#    test_input

#    delete_peice
#    check
#    checkmate
