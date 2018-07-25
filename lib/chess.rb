class Piece
    # Create a chess peices with a name, # of moves, and color
    attr_accessor :num_moves
    attr_reader :name, :color
    def initialize(name, color)
        @name = name
        @color = color
        @num_moves = 0
    end

    def move
        @num_moves += 1
    end
end

class Board
    #create a chess board, each space has a name, coordiates, and a piece
    attr_accessor :piece, :spaces
    attr_reader :name, :x, :y
    @@spaces = []
    def initialize(name, x, y)
        @name = name
        @x = x
        @y = y
        @piece = nil
    end

    def get_piece
        @piece
    end

    def add_piece(unit)
        @piece = unit
    end

    def delete
        @piece = nil
    end

    def self.add_space(space)
        @@spaces << space
    end

    def self.find_space(name)
        @@spaces.each do |space|
            return space if space.name == name
        end
    end

    def self.get_spaces
        @@spaces
    end
end

class Chess
    #create new game of chess
    def initialize
        create_board
        create_peices
    end
    
    def create_board
        8.times do |y|
            8.times do |x|
            letter = (x + 97).chr
                space_name = letter + (y+1).to_s
                Board.add_space(Board.new(space_name, x ,y))
            end
        end
    end

    def create_peices
        #add black peices to board
        Board.find_space('a1').add_piece(Piece.new('rook', 'white'))
        Board.find_space('h1').add_piece(Piece.new('rook', 'white'))
        Board.find_space('b1').add_piece(Piece.new('knight', 'white'))
        Board.find_space('g1').add_piece(Piece.new('knight', 'white'))
        Board.find_space('c1').add_piece(Piece.new('bishop', 'white'))
        Board.find_space('f1').add_piece(Piece.new('bishop', 'white'))
        Board.find_space('d1').add_piece(Piece.new('queen', 'white'))
        Board.find_space('e1').add_piece(Piece.new('king', 'white'))
        8.times do |num|
            letter = (num + 97).chr
            name = letter + 2.to_s
            Board.find_space(name).add_piece(Piece.new('pawn', 'white'))
        end

        #add black peices to board
        Board.find_space('a8').add_piece(Piece.new('rook', 'black'))
        Board.find_space('h8').add_piece(Piece.new('rook', 'black'))
        Board.find_space('b8').add_piece(Piece.new('knight', 'black'))
        Board.find_space('g8').add_piece(Piece.new('knight', 'black'))
        Board.find_space('c8').add_piece(Piece.new('bishop', 'black'))
        Board.find_space('f8').add_piece(Piece.new('bishop', 'black'))
        Board.find_space('d8').add_piece(Piece.new('queen', 'black'))
        Board.find_space('e8').add_piece(Piece.new('king', 'black'))
        8.times do |num|
            letter = (num + 97).chr
            name = letter + 7.to_s
            Board.find_space(name).add_piece(Piece.new('pawn', 'black'))
        end
    end

    def draw_board
        Board.get_spaces.each do |space|
            if space.piece
                puts "#{space.piece.name}, #{space.piece.color}" 
            else
                puts "empty"
            end

        end
    end
end

new_game = Chess.new
new_game.draw_board




                

