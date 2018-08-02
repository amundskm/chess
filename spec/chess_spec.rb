# These tests will drive the development of a # two person subject game that is played using 
# the command line.
require "rspec"
require "../lib/chess.rb"

RSpec.describe Piece do
    describe "move" do
        context "when a peice is moved to a different space" do
            subject { described_class.new("pawn", "white") }
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
                new_space = Board.new("a1", 0, 0, '⬜')
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
                new_space = Board.new("a1", 0, 0, '⬜')
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
                Board.new("a1", 0, 0, '⬜')
                Board.new("a2", 0, 1, '⬜')
                test = Board.new("a3", 0, 3, '⬜')
                expect(Board.find_space("a3").name).to eq test.name
                Board.empty
            end
        end
    end

    describe  "self.find_space_at" do
        context "when searching by name for a space" do
            xit "should return a space of the same name" do   
                Board.new("a1", 0, 0, '⬜')
                Board.new("a2", 0, 1, '⬜')
                test = Board.new("a3", 0, 3, '⬜')
                expect(Board.find_space_at(0,3).name).to eq test.name
                Board.empty
            end
        end
    end


    describe "self.get_spaces" do
        context "when looking for the array of all the spaces" do
            xit "should return the class array @@spaces" do
                Board.new("a1", 0, 0, '⬜')
                Board.new("a2", 0, 1, '⬜')
                Board.new("a2", 0, 2, '⬜')
                expect(Board.get_spaces.length).to eq 3
                Board.empty
            end
        end
    end

end

RSpec.describe Chess do
    

    describe "#build_board" do
        context "when the game is started, create all the spaces on the board" do
            subject{ described_class.new }
            xit "should create 64 spaces 8 X 8" do
                subject
                expect(Board.get_spaces.length).to eq 64
            end
        end
    end

    describe "#build_pieces" do
        context "when the game is started, create and place all subject peices on correct spaces" do
            subject{ described_class.new }
            xit "should put a rook on a1" do
                subject
                space = Board.find_space("a1")
                expect(space.piece.name).to eq "rook1"
            end
        end
    end

    #testing draw_board is visual

    describe "#connect_spaces" do
        subject{ described_class.new }
        context "when the board is build" do
            it "each space should have a reference to the spaces touching it." do
                subject.build_board
                subject.build_pieces
                subject.connect_spaces
                space = Board.find_space("a1")
                child_a = Board.find_space("a2")
                child_b = Board.find_space("b1")
                child_c = Board.find_space("b2")
                three_spaces = [child_a, child_b, child_c]
                expect(space.children).to contain_exactly three_spaces
            end

        end
    end

end



            # xit "each space should have a reference to the spaces touching it." do
            #     space = Board.find_space("e4")
            #     child_1 = Board.find_space("d3").name
            #     child_2 = Board.find_space("e3").name
            #     child_3 = Board.find_space("f3").name
            #     child_4 = Board.find_space("d4").name
            #     child_5 = Board.find_space("f4").name
            #     child_6 = Board.find_space("d5").name
            #     child_7 = Board.find_space("e5").name
            #     child_8 = Board.find_space("f5").name
                
            #     expected = [child_1, child_2, child_3, child_4, child_5, child_6, child_7, child_8]
            #     expect(space.children).to contain_exactly expected
            # end