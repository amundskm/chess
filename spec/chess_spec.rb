# These tests will drive the development of a # two person chess game that is played using 
# the command line.
require 'rspec'
require '../lib/chess.rb'

# NOTES: 
# when a new Spaces object is created it should have a name, coordinates, and a peice

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
Rspec.describe Game do
#    pawn_move
    describe "#pawn_move"
        context "when a pawn is called" do
            subject {described_class.new("pawn")}
            it "should be able to move 2 spaces forward on first turn" do
                #expect this to be true
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

end

Rspec.describe Gameplay do

    describe "#test_input" do
        context "when an player inputs a move" do
            it "should be a legal move" do
                
#    test_input

#    delete_peice
#    check
#    checkmate
