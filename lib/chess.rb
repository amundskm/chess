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
        build_board
        create_peices
        gameplay
    end

    def add_entry(pos, player)

    end
    
    def build_board
        8.times do |y|
            8.times do |x|
            letter = (x + 97).chr
                space_name = letter + (y+1).to_s
                subject.add_space(subject.new(space_name, x ,y))
            end
        end
    end

    def create_peices
        #add black peices to board
        subject.find_space('a1').add_piece(Piece.new('rook', 'white'))
        subject.find_space('h1').add_piece(Piece.new('rook', 'white'))
        subject.find_space('b1').add_piece(Piece.new('knight', 'white'))
        subject.find_space('g1').add_piece(Piece.new('knight', 'white'))
        subject.find_space('c1').add_piece(Piece.new('bishop', 'white'))
        subject.find_space('f1').add_piece(Piece.new('bishop', 'white'))
        subject.find_space('d1').add_piece(Piece.new('queen', 'white'))
        subject.find_space('e1').add_piece(Piece.new('king', 'white'))
        8.times do |num|
            letter = (num + 97).chr
            name = letter + 2.to_s
            Board.find_space(name).add_piece(Piece.new('pawn', 'white'))
        end

        #add black peices to board
        subject.find_space('a8').add_piece(Piece.new('rook', 'black'))
        subject.find_space('h8').add_piece(Piece.new('rook', 'black'))
        subject.find_space('b8').add_piece(Piece.new('knight', 'black'))
        subject.find_space('g8').add_piece(Piece.new('knight', 'black'))
        subject.find_space('c8').add_piece(Piece.new('bishop', 'black'))
        subject.find_space('f8').add_piece(Piece.new('bishop', 'black'))
        subject.find_space('d8').add_piece(Piece.new('queen', 'black'))
        subject.find_space('e8').add_piece(Piece.new('king', 'black'))
        8.times do |num|
            letter = (num + 97).chr
            name = letter + 7.to_s
            subject.find_space(name).add_piece(Piece.new('pawn', 'black'))
        end
    end

    def draw_board
        subject.get_spaces.each do |space|
            if space.piece
                puts "#{space.piece.name}, #{space.piece.color}" 
            else
                puts "empty"
            end

        end
    end

    def gameplay
        cont = false
        while cont == false
            [1,2].each do |player|
                cont = game_over
                break if cont != false
                draw_board
                add_entry(get_input(player), player)
            end
        end
        return cont
    end

    #TOD0: get_input
    #TODO: break_input
    #TODO: test_input
    #TODO: pawn_move
    #TODO: rook_move
    #TODO: knight_move
    #TODO: bishop_move
    #TODO: queen_move
    #TODO: king_move
end





                

