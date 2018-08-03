# These tests will drive the development of a # two person subject game that is played using 
# the command line.
require "rspec"
require "../lib/board.rb"
require "../lib/piece.rb"

RSpec.describe Board do
    describe "#add_piece" do
        context "when adding a peice in on a space" do
            it "should return the Piece object that is on that space" do
                new_space = Board.new("a1", 0, 0, '⬜')
                new_rook = Piece.new("rook", "white", '♖')
                new_space.add_piece(new_rook)
                expect(new_space.piece).to eq new_rook
                Board.empty
            end
        end
    end

    describe "#delete" do
        context "when a peice is moved to a different space, or removed from the game" do 
            it "should remove the piece from the space" do
                new_space = Board.new("a1", 0, 0, '⬜')
                new_rook = Piece.new("rook", "white", '♖')
                new_space.add_piece(new_rook)
                new_space.delete
                expect(new_space.piece).to eq nil
                Board.empty
            end
        end
    end
    
    describe  "self.find_space" do
        context "when searching by name for a space" do
            it "should return a space of the same name" do   
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
            it "should return a space of the same name" do   
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
            it "should return the class array @@spaces" do
                Board.new("a1", 0, 0, '⬜')
                Board.new("a2", 0, 1, '⬜')
                Board.new("a2", 0, 2, '⬜')
                expect(Board.get_spaces.length).to eq 3
                Board.empty
            end
        end
    end

end