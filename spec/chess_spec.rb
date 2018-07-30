# These tests will drive the development of a # two person chess game that is played using 
# the command line.
require 'rspec'
require '../lib/chess.rb'

# RSpec.describe Piece do
#     describe "move" do
#         context "when a peice is moved to a different space" do
#             subject { described_class.new('pawn', 'white') }
#             it "should incriment <num_move> by 1" do
#                 subject.move
#                 expect(subject.num_moves).to eq 1
#             end
#         end
#     end
# end

# describe Board do
#     describe "#add_piece" do
#         context "when adding a peice in on a space" do
#             it "should return the Piece object that is on that space" do
#                 new_space = Board.new('a1', 0, 0)
#                 new_rook = Piece.new("rook", "white")
#                 new_space.add_piece(new_rook)
#                 expect(new_space.piece).to eq new_rook
#                 Board.empty
#             end
#         end
#     end

#     describe "#delete" do
#         context "when a peice is moved to a different space, or removed from the game" do 
#             it "should remove the piece from the space" do
#                 new_space = Board.new('a1', 0, 0)
#                 new_rook = Piece.new("rook", "white")
#                 new_space.add_piece(new_rook)
#                 new_space.delete
#                 expect(new_space.piece).to eq nil
#                 Board.empty
#             end
#         end
#     end
    
#     describe  "self.find_space" do
#         context "when searching by name for a space" do
#             it "should return a space of the same name" do   
#                 Board.new("a1", 0, 0)
#                 Board.new("a2", 0, 1)
#                 test = Board.new("a3", 0, 3)
#                 expect(Board.find_space("a3")).to eq test
#                 Board.empty
#             end
#         end
#     end


#     describe "self.get_spaces" do
#         context "when looking for the array of all the spaces" do
#             it "should return the class array @@spaces" do
#                 Board.new("a1", 0, 0)
#                 Board.new("a2", 0, 1)
#                 Board.new("a2", 0, 2)
#                 expect(Board.get_spaces.length).to eq 3
#                 Board.empty
#             end
#         end
#     end

# end

RSpec.describe Chess do
    subject{ described_class.new }

    describe "build_board" do
        context "when the game is started, create all the spaces on the board" do
            it "should create 64 spaces 8 X 8" do
                chess = described_class.new
                chess.build_board
                expect(Board.get_spaces.length).to eq 64
            end
        end
    end

    describe "build_pieces" do
        
        context "when the game is started, create and place all chess peices on correct spaces" do
            it "should put a rook on 'a1'" do
                chess = described_class.new
                chess.build_board
                chess.build_pieces
                space = Board.find_space('a1')
                expect(space.piece.name).to eq 'rook'
            end
        end
    end

    describe "move_piece" do
        context "when a player wants to move a piece, and it is determined to be a legal move" do
            it "should add the piece to the new space, and delete it from the old space" do
                chess = described_class.new
                chess.build_board
                chess.build_pieces
                old_space = Board.find_space('a2')
                new_space = Board.find_space('a4')
                chess.move_piece(old_space, new_space)
                expect(old_space.piece).to eq nil
                expect(new_space.piece.name).to eq 'pawn'
            end
        end
    end

    describe "#pawn_move" do
        context "when a pawn is called" do
            it "should be able to move 2 spaces forward on first turn" do
                chess = described_class.new
                chess.build_board
                chess.build_pieces
                start = Board.find_space('a2')
                finish = Board.find_space('a4')
                expect(chess.pawn_move(start, finish)).to be true
            end

            it "should not be able to move two spaces after the first turn" do
                chess = described_class.new
                chess.build_board
                chess.build_pieces
                start = Board.find_space('a2')
                finish = Board.find_space('a4')
                chess.move_piece(start, finish)
                new_start = Board.find_space('a4')
                new_finish = Board.find_space('a6')
                expect(chess.pawn_move(new_start, new_finish)).to be false
            end

            it "should be able to move 1 space after the first turn" do
                chess = described_class.new
                chess.build_board
                chess.build_pieces
                start = Board.find_space('a2')
                finish = Board.find_space('a3')
                Board.find_space('a2').piece.num_moves = 2
                expect(chess.pawn_move(start, finish)).to be true
                new_finish = Board.find_space('a4')
                expect(chess.pawn_move(start, new_finish)).to be false
            end

            it "should not be able to move other than as above" do
                chess = described_class.new
                chess.build_board
                chess.build_pieces
                start = Board.find_space('a2')
                finish = Board.find_space('a6')
                expect(chess.pawn_move(start, finish)).to be false
            end

            it "should not be able to move forward to a position that already has a peice there" do
                chess = described_class.new
                chess.build_board
                chess.build_pieces
                start = Board.find_space('a2')
                finish = Board.find_space('a3')
                chess.move_piece(Board.find_space('a7'), Board.find_space('a3'))
                expect(chess.pawn_move(start, finish)).to be false
            end
        end
    end

    describe "#rook_move" do 
        context "when a rook is called" do
            it "should be able to move vertically" do
                chess = described_class.new
                chess.build_board
                chess.build_pieces
                Board.find_space('a2').delete
                start = Board.find_space('a1')
                finish = Board.find_space('a4')
                expect(subject.rook_move(start, finish)).to be true
            end
            it "should be able to move horizontally" do
                chess = described_class.new
                chess.build_board
                chess.build_pieces
                start = Board.find_space('a1')
                middle = Board.find_space('a4')
                finish = Board.find_space('c4')
                subject.move_piece(start, middle)
                expect(subject.rook_move(middle, finish)).to be true
            end

            it "should not be able to move other than above" do
                chess = described_class.new
                chess.build_board
                chess.build_pieces
                start = Board.find_space('a1')
                middle = Board.find_space('a4')
                finish = Board.find_space('c5')
                subject.move_piece(start, middle)
                expect(subject.rook_move(middle, finish)).to be false
            end

            it "should not move past any peices" do
                chess = described_class.new
                chess.build_board
                chess.build_pieces
                start = Board.find_space('a1')
                finish = Board.find_space('a4')
                expect(subject.rook_move(start, finish)).to be false
            end

        end
    end

    # describe "bishop_move" do
    #     subject{ described_class.new }
    #     context "when a bishop is called" do
    #         it "should be able to move up left diagonally" do
    #             Board.find_space('b2').delete
    #             expect(subject.bishop_move('c1', 'a3')).to be true
    #         end
    #         it "should be able to move up right diagonally" do
    #             Board.find_space('d2').delete
    #             expect(subject.bishop_move('c1', 'e3')).to be true
    #         end
    #         it "should be able to move down left diagonally" do
    #             Board.find_space('b2').delete
    #             subject.move_piece('c1', 'a3')
    #             expect(subject.bishop_move('a3', 'c1')).to be true
    #         end
    #         it "should be able to move down right diagonally" do
    #             Board.find_space('d2').delete
    #             subject.move_piece('c1', 'e3')
    #             expect(subject.bishop_move('e3', 'c1')).to be true
    #         end
            
    #         it "should not be able to move other than above" do
    #              subject.move_piece('c1', 'a3')
    #              expect(subject.bishop_move('a3', 'c3')).to be false
    #         end

    #         it "should not be able to move past any peices" do
    #             subject.move_piece('c1', 'e3')
    #             expect(subject.bishop_move('e3', 'c1')).to be false
    #         end
    #     end
    # end


    # describe "knight_move" do
    #     subject{ described_class.new }
    #     context "when a knight is called" do
    #         it "should be able to move (x,y): +2 , +1" do
    #             Board.find_space('d2').delete
    #             expect(subject.knight_move('b1', 'd2')).to be true
    #         end

    #         it "should be able to move (x,y): +1, +2" do
    #             expect(subject.knight_move('g1', 'h3')).to be true
    #         end

    #         it "should be able to move (x,y): -2, +1" do
    #             Board.find_space('e2').delete
    #             expect(subject.knight_move('g1', 'e2')).to be true
    #         end

    #         it "should be able to move (x,y): -1, +2" do
    #             expect(subject.knight_move('b1', 'a3')).to be true
    #         end

    #         it "should be able to move (x,y): +2 , -1" do
    #             Board.find_space('e2').delete
    #             subject.move_piece('b1','c3')
    #             expect(subject.knight_move('c3', 'e2')).to be true
    #         end

    #         it "should be able to move (x,y): +1, -2" do
    #             Board.find_space('d1').delete
    #             subject.move_piece('b1','c3')
    #             expect(subject.knight_move('c3', 'd1')).to be true
    #         end

    #         it "should be able to move (x,y): -2, -1" do
    #             Board.find_space('d2').delete
    #             subject.move_piece('g1','f3')
    #             expect(subject.knight_move('f3', 'd2')).to be true
    #         end

    #         it "should be able to move (x,y): -1, -2" do
    #             subject.move_piece('b1','c3')
    #             expect(subject.knight_move('c3', 'b1')).to be true
    #         end

    #         it "should not move other than as above" do
    #             expect(subject.knight_move('b1', 'e5')).to be false
    #         end

    #     end
    # end

    # describe "#king_move" do
    #     subject{ described_class.new }
    #     context "when a king is called" do
    #         it "should move horiztonally 1 space" do
    #             subject.move_piece('e1','e4')
    #             expect.king_move('e4', 'd4').to be true
    #             expect.king_move('e4', 'f4').to be true
    #         end
    #         it "should move vertically 1 space" do
    #             subject.move_piece('e1','e4')
    #             expect.king_move('e4', 'e5').to be true
    #             expect.king_move('e4', 'e3').to be true
    #         end
    #         it "should move diagonally 1 space" do
    #             subject.move_piece('e1','e4')
    #             expect.king_move('e4', 'd5').to be true
    #             expect.king_move('e4', 'f5').to be true
    #             expect.king_move('e4', 'd3').to be true
    #             expect.king_move('e4', 'f3').to be true
    #         end

    #         it "should only move as above" do
    #             subject.move_piece('e1','e4')
    #             expect.king_move('e4', 'h4').to be false
    #         end

    #         it "should not put itself in check" do 
    #             # TODO figure this out
    #         end

    #     end
    # end

    # describe "#queen_move" do
    #     subject{ described_class.new }
    #     context "when a queen is called" do
    #         it "should move horiztonally" do
    #             subject.move_piece('d1','d4')
    #             expect.queen_move('d4', 'h4').to be true
    #             expect.queen_move('d4', 'a4').to be true
    #         end

    #         it "should move vertically" do
    #             subject.move_piece('d1','d4')
    #             expect.queen_move('d4', 'd6').to be true
    #             expect.queen_move('d4', 'd3').to be true
    #         end

    #         it "should move diagonally" do
    #             subject.move_piece('d1','d4')
    #             expect.queen_move('d4', 'f6').to be true
    #             expect.queen_move('d4', 'b6').to be true
    #             expect.queen_move('d4', 'e3').to be true
    #             expect.queen_move('d4', 'c3').to be true
    #         end

    #         it "should not move past any peices" do 
    #             expect.queen_move('d1', 'd4').to be false
    #         end

    #     end
    # end

    # describe "#test_input" do
    #     subject{ described_class.new }
    #     context "when an player inputs a move" do
    #         it "should be a legal move" do
    #         end
    #     end
    # end

    # describe "#capture" do
    #     subject{ described_class.new }
    #     context "When a piece is legally moved to a position already occupied by an enemy piece" do
    #         it "should delete the enemy piece that is there and add the new piece to the space, and remove the new piece from its original position" do
    #             Board.find_space('a2').delete
    #             subject.capture('a1', 'a7')
    #             expect(Board.find_space('a1').peice).to eq nil
    #             expect(Board.find_space('a1').peice.name).to eq 'rook'
    #             expect(Board.find_space('a1').peice.color).to eq 'white'
    #         end
    #     end
    # end

    # describe "promotion" do
    #     subject{ described_class.new }
    #     context "when a pawn reaches the last row of the enemy's side of the board" do
    #         it "can be promoted to any piece the player desires" do
    #             Board.find_space('a7').delete
    #             Board.find_space('a8').delete
    #             subject.move_piece('a2', 'a8')
    #             subject.promotion('a8', 'queen')
    #             expect(Board.find_space('a8').piece.name).to eq 'queen'
    #         end
    #     end
    # end

    # describe "check" do
    #     subject{ described_class.new }
    #     context "when a king can be attacked on the next turn, but can escape a king is in check" do
    #         it "should return the king color if the king can be attacked" do
    #             expect(subject.check).to be false
    #             subject.move_piece('e1', 'e6')
    #             expect(subject.check).to eq 'white'
    #         end
    #     end
    # end

    # describe "checkmate" do
    #     subject{ described_class.new }
    #     context "when a king can be attacked on the next, and can't escape turn a king is in check" do
    #         it "should return the king color if the king can be attacked" do
    #             expect(subject.check).to be false
    #             Board.find_space('e7').delete
    #             subject.move_piece('d1', 'e7')
    #             subject.move_pieve('a1', 'e6')
    #             expect(subject.check).to eq 'black'
    #         end
    #     end
    # end

end

