class Piece
    # Create a chess peices with a name, # of moves, and color
    attr_accessor :num_moves, :white_pieces, :black_pieces
    attr_reader :name, :color, :unicode

    @@white_pieces = []
    @@black_pieces = []

    def initialize(name, color, unicode)
        @name = name
        @color = color
        @num_moves = 0
        @unicode = unicode   
        @@white_pieces << self if color == 'white'
        @@black_pieces << self if color == 'black'
    end

    def move
        @num_moves += 1
    end

    def self.get_black_pieces
        @@black_pieces
    end

    def self.get_white_pieces
        @@white_pieces
    end

    
end

class Board
    #create a chess board, each space has a name, coordiates, and a piece
    attr_accessor :piece, :spaces, :children
    attr_reader :name, :x, :y, :color

    @@spaces = []

    def initialize(name, x, y, color)
        @name = name
        @x = x
        @y = y
        @piece = nil
        @children = []
        @color = color
        @@spaces << self
    end

    def get_touching
        @touching
    end

    def self.empty
        @@spaces = []
    end

    def add_piece(unit)
        @piece = unit
    end

    def add_child(child)
        @children << child
    end

    def delete
        @piece = nil
    end

    def self.find_space(name)
        @@spaces.each { |space| return space  if space.name == name }
    end

    def self.find_space_at(x,y)
        @@spaces.each { |space| return space if (space.x == x && space.y == y) }
    end

    # def self.find_piece(piece, color)
    #     @@spaces.each { |space| return space  if (space.piece != nil) && (space.piece.name == piece) && (space.piece.color == color) }
    # end

    def self.get_spaces
        @@spaces
    end
end

class Chess
    #create new game of chess
    def initialize
    end

    def build_board
        8.times do |y|
            8.times do |x|
            letter = (x + 97).chr
                space_name = letter + (y+1).to_s
                if y.even? && x.even?
                    color = '⬜'
                elsif y.even? && x.odd?
                    color = '⬛'
                elsif y.odd? && x.odd?
                    color = '⬜'
                elsif y.odd? && x.even?
                    color = '⬛'
                end
                Board.new(space_name, x ,y, color)
            end
        end
    end

    def build_pieces
        #add white peices to board
        Board.find_space('a1').add_piece(Piece.new('rook1', 'white', '♖'))
        Board.find_space('h1').add_piece(Piece.new('rook2', 'white', '♖'))
        Board.find_space('b1').add_piece(Piece.new('knight1', 'white', '♘'))
        Board.find_space('g1').add_piece(Piece.new('knight2', 'white', '♘'))
        Board.find_space('c1').add_piece(Piece.new('bishop1', 'white', '♗'))
        Board.find_space('f1').add_piece(Piece.new('bishop2', 'white', '♗'))
        Board.find_space('d1').add_piece(Piece.new('queen', 'white', '♕'))
        Board.find_space('e1').add_piece(Piece.new('king', 'white', '♔'))
        8.times do |num|
            letter = (num + 97).chr
            name = letter + 2.to_s
            Board.find_space(name).add_piece(Piece.new('pawn', 'white', '♙'))
        end

        #add black peices to board
        Board.find_space('a8').add_piece(Piece.new('rook1', 'black', '♜'))
        Board.find_space('h8').add_piece(Piece.new('rook2', 'black', '♜'))
        Board.find_space('b8').add_piece(Piece.new('knight1', 'black', '♞'))
        Board.find_space('g8').add_piece(Piece.new('knight2', 'black', '♞'))
        Board.find_space('c8').add_piece(Piece.new('bishop1', 'black', '♝'))
        Board.find_space('f8').add_piece(Piece.new('bishop2', 'black', '♝'))
        Board.find_space('d8').add_piece(Piece.new('queen', 'black', '♛'))
        Board.find_space('e8').add_piece(Piece.new('king', 'black', '♚'))
        8.times do |num|
            letter = (num + 97).chr
            name = letter + 7.to_s
            Board.find_space(name).add_piece(Piece.new('pawn', 'black', '♟'))
        end
    end

    def draw_board
        (7).downto(0) do |y|
            line = "#{y+1}"
            8.times do |x|
                space = Board.find_space_at(x,y)
                if space.piece != nil
                    line += " #{space.piece.unicode}"
                else
                    line += " #{space.color}"
                end
            end
            puts line
        end

        puts "  a b c d e f g h"
    end

    def connect_spaces
        spaces = Board.get_spaces
        spaces.each do |space|
            [-1, 0, 1].each do |x|
                [-1, 0, 1].each do |y|
                    new_x = space.x + x
                    new_y = space.y + y
                    if (new_x >= 0 && new_x <= 7) && (new_y >= 0 && new_y <= 7) && (new_x != space.x ||new_y != space.y)
                        child = Board.find_space_at(new_x, new_y)
                        space.add_child(child)
                    end
                end
            end
        end
    end
   
end

new_game = Chess.new
new_game.build_board
new_game.build_pieces
new_game.connect_spaces
space = Board.find_space('e4')
space.children.each { |child| puts child.name}