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
    subject{ described_class.new }

    describe "build_board" do
        context "when the game is started, create all the spaces on the board" do
            it "should create 64 spaces 8 X 8" do
                expect(Board.get_spaces.length).to eq 64
            end
        end
    end

    describe "build_pieces" do
        context "when the game is started, create and place all chess peices on correct spaces" do
            it "should put a rook on 'a1'" do
                space = Board.find_space('a1')
                expect(space.piece.name).to eq 'rook'
            end
        end
    end

    describe "move_piece" do
        context "when a player wants to move a piece, and it is determined to be a legal move" do
            it "should add the piece to the new space, and delete it from the old space" do
                subject.move_piece('a2', 'a4')
                old_space = Board.find_space('a2')
                new_space = Board.find_space('a4')
                expect(old_space.peice).to eq nil
                expect(new_space.piece.name).to eq 'pawn'
            end
        end
    end

#    pawn_move
    describe "#pawn_move"
        context "when a pawn is called" do
            
            it "should be able to move 2 spaces forward on first turn" do
                expect(subject.pawn_move('a2', 'a4')).to be true
                Board.find_space('a2').piece.num_move = 2
                expect(subject.pawn_move('a2', 'a4')).to be false
            end

            it "should be able to move 1 space after the first turn" do
                Board.find_space('a2').piece.num_move = 2
                expect(subject.pawn_move('a2', 'a3')).to be true
                expect(subject.pawn_move('a2', 'a4')).to be false
            end

            it "should not be able to move other than as above" do
                expect(subject.pawn_move('a2', 'c6').to be false
            end

            it "should not be able to move forward to a position that already has a peice there" do
                subject.move_piece('a7', 'a3')
                expect(subject.pawn_move('a2', 'a3')).to be false
            end
        end
    end
#    rook_move
    describe "#rook_move"
        context "when a rook is called" do
            it "should be able to move vertically" do
                Board.find_space('a2').delete
                expect(subject.rook_move('a1', 'a4')).to be true
            end
            it "should be able to move horizontally" do
                Board.find_space('a2').delete
                subject.move_piece('a1', 'a4')
                expect(subject.rook_move('a4', 'c4')).to be true
            end

            it "should not be able to move other than above" do
                subject.move_piece('a1', 'a4')
                expect(subject.rook_move('a4', 'c5')).to be false
            end

            it "should not move past any peices" do
                expect(subject.rook_move('a1', 'a4')).to be false
            end

        end
    end

#    bishop_move
    describe "bishop_move" do
        context "when a bishop is called" do
            it "should be able to move up left diagonally" do
                Board.find_space('b2').delete
                expect(subject.bishop_move('c1', 'a3')).to be true
            end
            it "should be able to move up right diagonally" do
                Board.find_space('d2').delete
                expect(subject.bishop_move('c1', 'e3')).to be true
            end
            it "should be able to move down left diagonally" do
                Board.find_space('b2').delete
                subject.move_piece('c1', 'a3')
                expect(subject.bishop_move('a3', 'c1')).to be true
            end
            it "should be able to move down right diagonally" do
                Board.find_space('d2').delete
                subject.move_piece('c1', 'e3')
                expect(subject.bishop_move('e3', 'c1')).to be true
            end
            
            it "should not be able to move other than above" do
                 subject.move_piece('c1', 'a3')
                 expect(subject.bishop_move('a3', 'c3')).to be false
            end

            it "should not be able to move past any peices" do
                subject.move_piece('c1', 'e3')
                expect(subject.bishop_move('e3', 'c1')).to be false
            end
        end
    end

#    knight_move
    describe "knight_move" do
        context "when a knight is called" do
            it "should be able to move (x,y): +2 , +1" do
                Board.find_space('d2').delete
                expect(subject.knight_move('b1', 'd2')).to be true
            end

            it "should be able to move (x,y): +1, +2" do
                expect(subject.knight_move('g1', 'h3')).to be true
            end

            it "should be able to move (x,y): -2, +1" do
                Board.find_space('e2').delete
                expect(subject.knight_move('g1', 'e2')).to be true
            end

            it "should be able to move (x,y): -1, +2" do
                expect(subject.knight_move('b1', 'a3')).to be true
            end

            it "should be able to move (x,y): +2 , -1" do
                Board.find_space('e2').delete
                subject.move_piece('b1','c3')
                expect(subject.knight_move('c3', 'e2')).to be true
            end

            it "should be able to move (x,y): +1, -2" do
                Board.find_space('d1').delete
                subject.move_piece('b1','c3')
                expect(subject.knight_move('c3', 'd1')).to be true
            end

            it "should be able to move (x,y): -2, -1" do
                Board.find_space('d2').delete
                subject.move_piece('g1','f3')
                expect(subject.knight_move('f3', 'd2')).to be true
            end

            it "should be able to move (x,y): -1, -2" do
                subject.move_piece('b1','c3')
                expect(subject.knight_move('c3', 'b1')).to be true
            end

            it "should not move other than as above" do
                expect(subject.knight_move('b1', 'e5').to be false
            end

        end
    end
#    king_move
    describe "#king_move"
        contect "when a king is called" do
            it "should move horiztonally 1 space" do
                subject.move_piece('e1','e4')
                expect.king_move('e4', 'd4').to be true
                expect.king_move('e4', 'f4').to be true
            end
            it "should move vertically 1 space" do
                subject.move_piece('e1','e4')
                expect.king_move('e4', 'e5').to be true
                expect.king_move('e4', 'e3').to be true
            end
            it "should move diagonally 1 space" do
                subject.move_piece('e1','e4')
                expect.king_move('e4', 'd5').to be true
                expect.king_move('e4', 'f5').to be true
                expect.king_move('e4', 'd3').to be true
                expect.king_move('e4', 'f3').to be true
            end

            it "should only move as above" do
                subject.move_piece('e1','e4')
                expect.king_move('e4', 'h4').to be false
            end

            it "should not put itself in check" do 
                # TODO figure this out
            end

        end
    end
#    queen_move
    describe "#queen_move"
        context "when a queen is called" do
            it "should move horiztonally" do
                subject.move_piece('d1','d4')
                expect.queen_move('d4', 'h4').to be true
                expect.queen_move('d4', 'a4').to be true
            end

            it "should move vertically" do
                subject.move_piece('d1','d4')
                expect.queen_move('d4', 'd6').to be true
                expect.queen_move('d4', 'd3').to be true
            end

            it "should move diagonally" do
                subject.move_piece('d1','d4')
                expect.queen_move('d4', 'f6').to be true
                expect.queen_move('d4', 'b6').to be true
                expect.queen_move('d4', 'e3').to be true
                expect.queen_move('d4', 'c3').to be true
            end

            it "should not move past any peices" do 
                expect.queen_move('d1', 'd4').to be false
            end

        end
    end

    describe "#test_input" do
        context "when an player inputs a move" do
            it "should be a legal move" do
            end
        end
    end
                
#    test_input
#    capture
#    delete_peice
#    check
#    checkmate
#    promotion
#    split
#    get_input
#    promotion_input
end

