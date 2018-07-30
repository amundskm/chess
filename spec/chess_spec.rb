# These tests will drive the development of a # two person subject game that is played using 
# the command line.
require 'rspec'
require '../lib/chess.rb'

RSpec.describe Piece do
    describe "move" do
        context "when a peice is moved to a different space" do
            subject { described_class.new('pawn', 'white') }
            xit "should incriment <num_move> by 1" do
                subject.move
                expect(subject.num_moves).to eq 1
            end
        end
    end
end

RSpec.describe Board do
    describe "#add_piece" do
        context "when adding a peice in on a space" do
            xit "should return the Piece object that is on that space" do
                new_space = Board.new('a1', 0, 0)
                new_rook = Piece.new("rook", "white")
                new_space.add_piece(new_rook)
                expect(new_space.piece).to eq new_rook
                Board.empty
            end
        end
    end

    describe "#delete" do
        context "when a peice is moved to a different space, or removed from the game" do 
            xit "should remove the piece from the space" do
                new_space = Board.new('a1', 0, 0)
                new_rook = Piece.new("rook", "white")
                new_space.add_piece(new_rook)
                new_space.delete
                expect(new_space.piece).to eq nil
                Board.empty
            end
        end
    end
    
    describe  "self.find_space" do
        context "when searching by name for a space" do
            xit "should return a space of the same name" do   
                Board.new("a1", 0, 0)
                Board.new("a2", 0, 1)
                test = Board.new("a3", 0, 3)
                expect(Board.find_space("a3")).to eq test
                Board.empty
            end
        end
    end


    describe "self.get_spaces" do
        context "when looking for the array of all the spaces" do
            xit "should return the class array @@spaces" do
                Board.new("a1", 0, 0)
                Board.new("a2", 0, 1)
                Board.new("a2", 0, 2)
                expect(Board.get_spaces.length).to eq 3
                Board.empty
            end
        end
    end

end

RSpec.describe Chess do
    

    describe "build_board" do
        context "when the game is started, create all the spaces on the board" do
            subject{ described_class.new }
            xit "should create 64 spaces 8 X 8" do
                subject
                expect(Board.get_spaces.length).to eq 64
            end
        end
    end

    describe "build_pieces" do
        
        context "when the game is started, create and place all subject peices on correct spaces" do
            subject{ described_class.new }
            xit "should put a rook on 'a1'" do
                subject
                space = Board.find_space('a1')
                expect(space.piece.name).to eq 'rook'
            end
        end
    end

    describe "move_piece" do
        subject{ described_class.new }
        context "when a player wants to move a piece, and it is determined to be a legal move" do
            xit "should add the piece to the new space, and delete it from the old space" do
                subject
                start = Board.find_space('a2')
                finish = Board.find_space('a4')
                subject.move_piece(start, finish)
                expect(start.piece).to eq nil
                expect(finish.piece.name).to eq 'pawn'
            end

            xit "should delete the enemy piece that is there and add the new piece to the space, and remove the new piece from its original position" do
                subject 
                Board.find_space('a2').delete
                start = Board.find_space('a1')
                finish = Board.find_space('a7')
                subject.move_piece(start, finish)
                expect(Board.find_space('a1').piece).to eq nil
                expect(Board.find_space('a7').piece.name).to eq 'rook'
                expect(Board.find_space('a7').piece.color).to eq 'white'
            end

        end
    end

    describe "#no_jump" do
        subject{ described_class.new }
        context "when a piece is called" do
            it "should not jump over a piece to get to its final position" do
                subject
                start = Board.find_space('a1')
                finish = Board.find_space('a4')
                expect(subject.no_jump(start,finish)).to be false
            end
        end
    end

    describe "#pawn_move" do
        context "when a pawn is called" do
            subject{ described_class.new }
            xit "should be able to move 2 spaces forward on first turn" do
                subject
                start = Board.find_space('a2')
                finish = Board.find_space('a4')
                expect(subject.pawn_move(start, finish)).to be true
            end

            xit "should not be able to move two spaces after the first turn" do
                subject
                start = Board.find_space('a2')
                finish = Board.find_space('a4')
                subject.move_piece(start, finish)
                new_start = Board.find_space('a4')
                new_finish = Board.find_space('a6')
                expect(subject.pawn_move(new_start, new_finish)).to be false
            end

            xit "should be able to move 1 space after the first turn" do
                subject
                start = Board.find_space('a2')
                finish = Board.find_space('a3')
                Board.find_space('a2').piece.num_moves = 2
                expect(subject.pawn_move(start, finish)).to be true
                new_finish = Board.find_space('a4')
                expect(subject.pawn_move(start, new_finish)).to be false
            end

            xit "should not be able to move other than as above" do
                subject
                start = Board.find_space('a2')
                finish = Board.find_space('a6')
                expect(subject.pawn_move(start, finish)).to be false
            end

            xit "should not be able to move forward to a position that already has a peice there" do
                subject
                start = Board.find_space('a2')
                finish = Board.find_space('a3')
                subject.move_piece(Board.find_space('a7'), Board.find_space('a3'))
                expect(subject.pawn_move(start, finish)).to be false
            end

            it "should not be able to jump a piece to get to its final position" do
                subject
                start = Board.find_space('a2')
                finish = Board.find_space('a4')
                subject.move_piece(Board.find_space('b2'), Board.find_space('a3'))
                expect(subject.pawn_move(start, finish)).to be false
            end
        end
    end

    describe "#rook_move" do 
        context "when a rook is called" do
            subject{ described_class.new }
            it "should be able to move vertically" do
                subject
                start = Board.find_space('a1')
                finish = Board.find_space('a4')
                Board.find_space('a2').delete
                expect(subject.rook_move(start, finish)).to be true
            end
            it "should be able to move horizontally" do
                subject
                start = Board.find_space('a1')
                middle = Board.find_space('a4')
                finish = Board.find_space('c4')
                subject.move_piece(start, middle)
                expect(subject.rook_move(middle, finish)).to be true
            end

            it "should not be able to move other than above" do
                subject
                start = Board.find_space('a1')
                middle = Board.find_space('a4')
                finish = Board.find_space('c5')
                subject.move_piece(start, middle)
                expect(subject.rook_move(middle, finish)).to be false
            end

            it "should not move past any peices" do
                subject
                start = Board.find_space('a1')
                finish = Board.find_space('a4')
                expect(subject.rook_move(start, finish)).to be false
            end

        end
    end

    describe "bishop_move" do
        subject{ described_class.new }
        context "when a bishop is called" do
            it "should be able to move up left diagonally" do
                subject
                start = Board.find_space('c1')
                finish = Board.find_space('a3')
                Board.find_space('b2').delete
                expect(subject.bishop_move(start, finish)).to be true
            end
            it "should be able to move up right diagonally" do
                subject
                start = Board.find_space('c1')
                finish = Board.find_space('e3')
                Board.find_space('d2').delete
                expect(subject.bishop_move(start, finish)).to be true
            end
            it "should be able to move down left diagonally" do
                subject
                start = Board.find_space('c1')
                finish = Board.find_space('a3')
                Board.find_space('b2').delete
                subject.move_piece(start, finish)
                expect(subject.bishop_move(finish, start)).to be true
            end
            it "should be able to move down right diagonally" do
                subject
                Board.find_space('d2').delete
                start = Board.find_space('c1')
                finish = Board.find_space('e3')
                subject.move_piece(start, finish)
                expect(subject.bishop_move(finish, start)).to be true
            end
            
            it "should not be able to move other than above" do
                subject
                start = Board.find_space('c1')
                middle = Board.find_space('a3')
                finish = Board.find_space('c3')
                 subject.move_piece(start, middle)
                 expect(subject.bishop_move(middle, finish)).to be false
            end

            it "should not be able to move past any peices" do
                subject
                start = Board.find_space('c1')
                finish = Board.find_space('e3')
                expect(subject.bishop_move(start, finish)).to be false
            end
        end
    end


    describe "knight_move" do
        subject{ described_class.new }
        context "when a knight is called" do
            xit "should be able to move (x,y): +2 , +1" do
                subject
                start = Board.find_space('b1')
                finish = Board.find_space('d2')
                Board.find_space('d2').delete
                expect(subject.knight_move(start, finish)).to be true
            end

            xit "should be able to move (x,y): +1, +2" do
                subject
                start = Board.find_space('g1')
                finish = Board.find_space('h3')
                expect(subject.knight_move(start, finish)).to be true
            end

            xit "should be able to move (x,y): -2, +1" do
                subject
                start = Board.find_space('g1')
                finish = Board.find_space('e2')
                Board.find_space('e2').delete
                expect(subject.knight_move(start, finish)).to be true
            end

            xit "should be able to move (x,y): -1, +2" do
                subject
                start = Board.find_space('b1')
                finish = Board.find_space('a3')
                expect(subject.knight_move(start, finish)).to be true
            end

            xit "should be able to move (x,y): +2 , -1" do
                subject
                start = Board.find_space('b1')
                middle = Board.find_space('c3')
                finish = Board.find_space('e2')
                Board.find_space('e2').delete
                subject.move_piece(start, middle)
                expect(subject.knight_move(middle, finish)).to be true
            end

            xit "should be able to move (x,y): +1, -2" do
                subject
                start = Board.find_space('b1')
                middle = Board.find_space('c3')
                finish = Board.find_space('d1')
                Board.find_space('d1').delete
                subject.move_piece(start, middle)
                expect(subject.knight_move(middle, finish)).to be true
            end

            xit "should be able to move (x,y): -2, -1" do
                subject
                start = Board.find_space('g1')
                middle = Board.find_space('f3')
                finish = Board.find_space('d2')
                Board.find_space('d2').delete
                subject.move_piece(start, middle)
                expect(subject.knight_move(middle, finish)).to be true
            end

            xit "should be able to move (x,y): -1, -2" do
                subject
                start = Board.find_space('b1')
                finish = Board.find_space('c3')
                subject.move_piece(start, finish)
                expect(subject.knight_move(finish, start)).to be true
            end

            xit "should not move other than as above" do
                subject
                start = Board.find_space('b1')
                finish = Board.find_space('e5')
                expect(subject.knight_move(start, finish)).to be false
            end

        end
    end

    describe "#king_move" do
        subject{ described_class.new }
        context "when a king is called" do
            xit "should move horiztonally 1 space" do
                subject
                start = Board.find_space('e1')
                middle = Board.find_space('e4')
                subject.move_piece(start, middle)
                left = Board.find_space('d4')
                right = Board.find_space('f4')
                expect(subject.king_move(middle, left)).to be true
                expect(subject.king_move(middle, right)).to be true
            end
            xit "should move vertically 1 space" do
                subject
                start = Board.find_space('e1')
                middle = Board.find_space('e5')
                subject.move_piece(start, middle)
                up = Board.find_space('e6')
                down = Board.find_space('e4')
                expect(subject.king_move(middle, up)).to be true
                expect(subject.king_move(middle, down)).to be true
            end
            xit "should move diagonally 1 space" do
                subject
                start = Board.find_space('e1')
                middle = Board.find_space('e4')
                subject.move_piece(start, middle)
                up_right = Board.find_space('f5')
                up_left = Board.find_space('d5')
                down_right = Board.find_space('f3')
                down_left = Board.find_space('d3')
                expect(subject.king_move(middle, up_right)).to be true
                expect(subject.king_move(middle, up_left)).to be true
                expect(subject.king_move(middle, down_right)).to be true
                expect(subject.king_move(middle, down_left)).to be true
            end

            xit "should only move as above" do
                subject
                start = Board.find_space('e1')
                middle = Board.find_space('e4')
                subject.move_piece(start, middle)
                finish = Board.find_space('h4')
                expect(subject.king_move(middle, finish)).to be false
            end

            # it "should not put itself in check" do 
            #     # TODO figure this out
            # end

        end
    end

    describe "#queen_move" do
        subject{ described_class.new }
        context "when a queen is called" do
            it "should move horiztonally" do
                subject
                start = Board.find_space('d1')
                middle = Board.find_space('d4')
                subject.move_piece(start, middle)
                right = Board.find_space('h4')
                left = Board.find_space('a4')
                expect(subject.queen_move(middle, left)).to be true
                expect(subject.queen_move(middle, right)).to be true
            end

            it "should move vertically" do
                subject
                start = Board.find_space('d1')
                middle = Board.find_space('d4')
                subject.move_piece(start, middle)
                up = Board.find_space('d6')
                down = Board.find_space('d3')
                expect(subject.queen_move(middle, up)).to be true
                expect(subject.queen_move(middle, down)).to be true
            end

            it "should move diagonally" do
                subject
                start = Board.find_space('d1')
                middle = Board.find_space('d4')
                subject.move_piece(start, middle)
                up_left = Board.find_space('f6')
                up_right = Board.find_space('b6')
                down_left = Board.find_space('e3')
                down_right = Board.find_space('c3')
                expect(subject.queen_move(middle, up_left)).to be true
                expect(subject.queen_move(middle, up_right)).to be true
                expect(subject.queen_move(middle, down_left)).to be true
                expect(subject.queen_move(middle, down_right)).to be true
            end

            it "should not move past any peices" do 
                subject
                start = Board.find_space('d1')
                finish = Board.find_space('d4')
                expect(subject.queen_move(start, finish)).to be false
            end

        end
    end

    # describe "#test_input" do
    #     subject{ described_class.new }
    #     context "when an player inputs a move" do
    #         it "should be a legal move" do
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

