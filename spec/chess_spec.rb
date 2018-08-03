# These tests will drive the development of a # two person subject game that is played using 
# the command line.
require "rspec"
require "../lib/chess.rb"
require "../lib/board.rb"
require "../lib/piece.rb"

RSpec.describe Chess do
    

    describe "#build_board" do
        context "when the game is started, create all the spaces on the board" do
            subject{ described_class.new }
            it "should create 64 spaces 8 X 8" do
                subject.build_board
                expect(subject.spaces.length).to eq 64
            end
        end
    end

    describe "#build_pieces" do
        context "when the game is started, create and place all subject peices on correct spaces" do
            subject{ described_class.new }
            it "should put a rook on a1" do
                subject
                subject.build_board
                subject.build_pieces
                space = subject.find_space("a1")
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
                space = subject.find_space("a1")
                child_a = subject.find_space("a2").name
                child_b = subject.find_space("b1").name
                child_c = subject.find_space("b2").name

                expect(space.children).to contain_exactly child_a, child_b, child_c
            end

            it "each space should have a reference to the spaces touching it." do
                subject.build_board
                subject.build_pieces
                subject.connect_spaces
                space = subject.find_space("e4")
                child_1 = subject.find_space("d3").name
                child_2 = subject.find_space("e3").name
                child_3 = subject.find_space("f3").name
                child_4 = subject.find_space("d4").name
                child_5 = subject.find_space("f4").name
                child_6 = subject.find_space("d5").name
                child_7 = subject.find_space("e5").name
                child_8 = subject.find_space("f5").name
                expect(space.children).to contain_exactly child_1, child_2, child_3, child_4, child_5, child_6, child_7, child_8
            end
        end
    end

    describe "#find_path" do
        subject{ described_class.new }
        context "when checking the path for obstruction" do
            it "should return the shortest path between two spaces" do
                subject.build_board
                subject.build_pieces
                subject.connect_spaces
                start = subject.find_space("a1")
                finish = subject.find_space('a4')
                child_1 = subject.find_space('a2')
                child_2 = subject.find_space('a3')
                expect(subject.find_path(start, finish)).to contain_exactly child_1, child_2
            end
        end
    end

    describe "check" do
    subject{ described_class.new }
    context "when a king can be attacked on the next turn, but can escape a king is in check" do
        it "should be true if the king can be attacked" do
            subject.build_board
            subject.build_pieces
            subject.connect_spaces
            start = subject.find_space('d1')
            finish = subject.find_space('f7')
            subject.move_piece(start, finish)
            expect(subject.check('black')).to eq finish
        end
    end

    end

    describe "checkmate" do
        subject{ described_class.new }
        context "when a king can be attacked on the next, and can't escape turn a king is in check" do
            it "should return the king color if the king can be attacked" do
                subject.build_board
                subject.build_pieces
                subject.connect_spaces
                subject.find_space('e7').delete
                queen_start = subject.find_space('d1')
                queen_finish = subject.find_space('f7')
                bishop_start = subject.find_space('f1')
                bishop_finish = subject.find_space('c6')
                subject.move_piece(queen_start, queen_finish)
                subject.move_piece(bishop_start, bishop_finish)
                expect(subject.checkmate(queen_finish)).to be true
            end
        end
    end
                


end



            