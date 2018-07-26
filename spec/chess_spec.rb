# These tests will drive the development of a # two person chess game that is played using 
# the command line.
require 'rspec'
require '../lib/chess.rb'

Rspec.describe Piece do
    describe "move" do
        context "when a peice is moved to a different space" do
            it "should incriment <num_move> by 1" do
                new_piece = Piece.new(pawn, white)
                new_peice.move
                expect(num_move).to eq 1
            end
        end
    end
end

RSpec.describe Board do
    subject{ described_class.new("a1", 0, 0) }
    describe "#add_piece" do
        context "when adding a peice in on a space" do
            it "should return the Piece object that is on that space" do
                
                new_rook = Piece.new("rook, white")
                subject.add_piece(new_rook)
                expect(new_space.piece).to eq new_rook
            end
        end
    end

    describe "#delete" do
        context "when a peice is moved to a different space, or removed from the game" do
            it "should remove the piece from the space" do
                new_rook = Piece.new("rook, white")
                subject.add_piece(new_rook)
                subject.delete
                expect(subject.piece).to eq nil
            end
        end
    end

    describe  "self.find_space" do
        context "when searching by name for a space" do
            it "should return a space of the same name" do
                subject.spaces << new_space
                expect(Board.find_space("a1")).to eq subject]
            end
        end
    end

    describe "self.add_space" do
        context "when a space is created" do
            it "should add the new space to the class array @@spaces" do
                Board.add_space(subject)
                expect(Board.find_space("a1")).to eq subject
            end
        end
    end

    describe "self.get_spaces" do
        context "when looking for the array of all the spaces" do
            it "should return the class array @@spaces" do
                Board.add_space(subject)
                expect(Board.get_spaces[0]).to eq subject
            end
        end
    end

end

#   get_input
Rspec.describe Chess do
#    pawn_move
    describe "#pawn_move"
        context "when a pawn is called" do

            it "should be able to move 2 spaces forward on first turn" do
                
            end

            it "should be able to move 1 space after the first turn" do
                #expect this to be true
            end

            it "should be able to capture a peice that is up and over 1" do
                #expect this to be true
            end

            it "should not be able to move to a position that already has a peice there" do
                #expect this to be false
            end
        end
    end
#    rook_move
    describe "#rook_move"
        context "when a rook is called" do
            it "should be able to move vertically" do
            end
            it "should be able to move horizontally" do
            end
            it "should not move past any peices" do
            end
            it "should be able to capture an enemy peice" do
            end
            it "should not land on a space that already has the same players peice already" do
            end
        end
    end

#    bishop_move
    describe "bishop_move" do
        context "when a bishop is called" do
            it "should be able to move up left diagonally" do
            end
            it "should be able to move up right diagonally" do
            end
            it "should be able to move down left diagonally" do
            end
            it "should be able to move down right diagonally" do
            end
            it "should not be able to move past any peices" do
            end
            it "should be able to capture an enemy peice" do
            end
            it "should not land on a space that already has the same players peice already" do
            end
        end
    end

#    knight_move
    describe "knight_move" do
        context "when a knight is called" do
            it "should be able to move (x,y): +2 , +1" do
            end
            it "should be able to move (x,y): +1, +2" do
            end
            it "should be able to move (x,y): -2, +1" do
            end
            it "should be able to move (x,y): -1, +2" do
            end
            it "should be able to move (x,y): +2 , -1" do
            end
            it "should be able to move (x,y): +1, -2" do
            end
            it "should be able to move (x,y): -2, -1" do
            end
            it "should be able to move (x,y): -1, -2" do
            end
            it "should be able to capture an enemy peice" do
            end
            it "should not land on a space that already has the same players peice already" do
            end
        end
    end
#    king_move
    describe "#king_move"
        contect "when a king is called" do
            it "should move horiztonally 1 space" do
            end
            it "should move vertically 1 space" do
            end
            it "should move diagonally 1 space" do
            end
            it "should not land on a space that already has the same players peice already" do
            end
            it "should not put itself in check" do 
            end
            it "should be able to capture an enemy peice" do
            end
        end
    end
#    queen_move
    describe "#queen_move"
        context "when a queen is called" do
            it "should move horiztonally" do
            end
            it "should move vertically" do
            end
            it "should move diagonally" do
            end
            it "should not land on a space that already has the same players peice already" do
            end
            it "should not move past any peices" do 
            end
            it "should be able to capture an enemy peice" do
            end
        end
    end

    describe "#test_input" do
        context "when an player inputs a move" do
            it "should be a legal move" do
                
#    test_input

#    delete_peice
#    check
#    checkmate
end

