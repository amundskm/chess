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
    attr_reader :name, :x, :y, :touching
    
    def initialize(name, x, y)
        @name = name
        @x = x
        @y = y
        @piece = nil
        @@spaces << self
        @touching = []
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

    def delete
        @piece = nil
    end

    def self.find_space(name)
        @@spaces.each do |space|
            return space if space.name === name
        end
    end

    def self.find_space_at(x,y)
        @@spaces.each do |space|
            return space if (space.x == x && space.y == y)
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
        build_board
        build_pieces
        #connect_spaces
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

    def connect_spaces
        Board.get_spaces.each do |space|
            [-1,0,1].each do |x|
                [-1,0,1].each do |y|
                    @touching << Board.find_space_at(x,y) unless (x == 0 and y == 0)
                end
            end
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
        finish.piece = start.piece
        start.delete
        finish.piece.move
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
        return true if (x_dist == 0) && (y_dist == 2) && (no_jump(start,finish)) && (finish.piece == nil) && (start.piece.num_moves == 0)
        return true if (x_dist == 0) && (y_dist == 1) && (finish.piece == nil)
        return false
    end

    def rook_move(start, finish)
        # INPUT: start = starting space, finish = ending space
        # OUTPUT: boolean if it is a legal move

        color = start.piece.color
        x_dist = start.x - finish.x
        (color == 'white')? (y_dist = finish.y - start.y) : (y_dist = start.y - finish.y)

        return true if (x_dist == 0) && no_jump(start, finish) && ((finish.piece == nil) ||(finish.piece.color != color))
        return true if (y_dist == 0) && no_jump(start, finish) && ((finish.piece == nil) ||(finish.piece.color != color))
        return false
    end

    def bishop_move(start, finish)
        # INPUT: start = starting space, finish = ending space
        # OUTPUT: boolean if it is a legal move
        color = start.piece.color
        x_dist = start.x - finish.x
        (color == 'white')? (y_dist = finish.y - start.y) : (y_dist = start.y - finish.y)

        return true if (x_dist.abs == y_dist.abs) && no_jump(start, finish) && ((finish.piece == nil) ||(finish.piece.color != color))
        return false
    end

    def knight_move(start, finish)
        # INPUT: start = starting space, finish = ending space
        # OUTPUT: boolean if it is a legal move

        color = start.piece.color
        x_dist = start.x - finish.x
        (color == 'white')? (y_dist = finish.y - start.y) : (y_dist = start.y - finish.y)

        return true if (x_dist.abs + y_dist.abs == 3) && (x_dist.abs <= 2) && (y_dist.abs <= 2) && ((finish.piece == nil) ||(finish.piece.color != color))
        return false
    end

    def king_move(start, finish)
        # INPUT: start = starting space, finish = ending space
        # OUTPUT: boolean if it is a legal move

        color = start.piece.color
        x_dist = start.x - finish.x
        (color == 'white')? (y_dist = finish.y - start.y) : (y_dist = start.y - finish.y)

        return true if (x_dist.abs <= 1) && (y_dist.abs <= 1) && ((finish.piece == nil) ||(finish.piece.color != color))
        return false

    end

    def queen_move(start, finish)
        color = start.piece.color
        x_dist = start.x - finish.x
        (color == 'white')? (y_dist = finish.y - start.y) : (y_dist = start.y - finish.y)

        return true if (x_dist == 0) && no_jump(start, finish) && ((finish.piece == nil) ||(finish.piece.color != color))
        return true if (y_dist == 0) && no_jump(start, finish) && ((finish.piece == nil) ||(finish.piece.color != color))
        return true if (x_dist.abs == y_dist.abs) && no_jump(start, finish) && ((finish.piece == nil) ||(finish.piece.color != color))
        return false
    end
    
    def no_jump(start, finish)
        # INPUT: start = starting space, finish = ending space
        # OUTPUT: boolean if it is a legal move
        color = start.piece.color
        x_dist = start.x - finish.x
        (color == 'white')? (y_dist = finish.y - start.y) : (y_dist = start.y - finish.y)

        return false unless (x_dist == 0) || (y_dist == 0) || (y_dist == x_dist)
        return true


    end 
end
