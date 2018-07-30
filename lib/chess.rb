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
        @@spaces << self
    end

    def self.empty
        @@spaces = []
    end

    def add_piece(unit)
        @piece = unit
    end

    def delete
        @piece = nil
    end

    def self.find_space(name)
        @@spaces.each do |space|
            return space if space.name === name
        end
    end

    def self.get_spaces
        @@spaces
    end
end

class Chess
    #create new game of chess
    def initialize
        Board.empty
    end

    def build_board
        8.times do |y|
            8.times do |x|
            letter = (x + 97).chr
                space_name = letter + (y+1).to_s
                Board.new(space_name, x ,y)
            end
        end
    end

    def build_pieces
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

        #TODO draw board should actually create a map of the board in the command prompt
    # def draw_board
    #     Board.get_spaces.each do |space|
    #         if space.piece
    #             puts "#{space.piece.name}, #{space.piece.color}" 
    #         else
    #             puts "empty"
    #         end

    #     end
    # end

    def move_piece(start, finish)
        piece = start.piece
        piece.move
        start.delete
        finish.piece = piece

    end

    # def gameplay
    #     cont = false
    #     while cont == false
    #         [1,2].each do |player|
    #             cont = game_over
    #             break if cont != false
    #             draw_board
    #             add_entry(get_input(player), player)
    #         end
    #     end
    #     return cont
    # end

    def get_input
        # INPUT: none
        # OUTPUT: 2 part string array, first part the space the player wants move from, second
        # part the splace the player wants to move to.
        while true
            puts "what space would you like to move and where"
            puts "input in the format <space_name> to <space_name>"
            puts "example: a2 to a3"
            #input= gets.chomp
            input = "a2 to a3"
            check = input.scan(/(\w)(\d) to (\w)(\d)/).flatten
            start = check[0] + check[1]
            finish = check[2] + check[2]
            return start, finish if check.length == 4
            puts "what you have entered does not have the correct format. Please try again."
        end
    end

    def test_input(start, finish, player)
        # INPUT: start = string, name of starting space finish = string, name of ending space
        # OUTPUT: returns false if it is not a legal move

        space_start = Board.find_space(start)
        space_end = Board.find_space(finish)
        piece = space_start.piece

        unless piece.color == player
            return false
        end

        case piece.name
        when "pawn"
            return pawn_move(space_start, space_end)
        when "rook"
            return rook(space_start, space_end)
        when "knight"
            return knight(space_start, space_end)
        when "bishop"
            return bishop(space_start, space_end)
        when "queen"
            return queen(space_start, space_end)
        end

        false
    end

    def pawn_move(start, finish)
        # INPUT: start = starting space, finish = ending space
        # OUTPUT: boolean if it is a legal move
        
        color = start.piece.color
        x_dist = start.x - finish.x
        (color == 'white')? (y_dist = finish.y - start.y) : (y_dist = start.y - finish.y) 

        return true if (x_dist == 1) && (y_dist == 1) && (finish.piece)
        return true if (x_dist == 0) && (y_dist == 2) && (finish.piece == nil) && (start.piece.num_moves == 0)
        return true if (x_dist == 0) && (y_dist == 1) && (finish.piece == nil)
        return false
    end

    def rook_move(start, finish)
        # INPUT: start = starting space, finish = ending space
        # OUTPUT: boolean if it is a legal move
        color = start.piece.color
        x_dist = start.x - finish.x
        (color == 'white')? (y_dist = finish.y - start.y) : (y_dist = start.y - finish.y)

        return true if (x_dist == 0) && no_jump(start, finish) && (finish.piece.color != color)
        return true if (y_dist == 0) && no_jump(start, finish) && (finish.piece.color != color)
        return false
    end

    def bishop_move(start, finish)
        # INPUT: start = starting space, finish = ending space
        # OUTPUT: boolean if it is a legal move
        color = start.piece.color
        x_dist = start.x - finish.x
        (color == 'white')? (y_dist = finish.y - start.y) : (y_dist = start.y - finish.y)

        return true if (x_dist.abs == y_dist.abs) && no_jump(start, finish) && (finish.piece.color != color)
    end

    def no_jump(start, finish)
        true #TODO: Actually write this
    end 

    #TODO: knight_move
    #TODO: bishop_move
    #TODO: queen_move
    #TODO: king_move
    #TODO: jumpstart
end


                

