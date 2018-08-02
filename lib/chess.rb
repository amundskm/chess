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
    attr_accessor :piece, :spaces, :children, :parent
    attr_reader :name, :x, :y, :color
    
    def initialize(name, x, y, color)
        @name = name
        @x = x
        @y = y
        @piece = nil
        @children = []
        @parent = nil
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

    def self.find_piece(piece, color)
        @@spaces.each do |space|
            if space.piece != nil
                return space if (space.piece.name == piece) && (space.piece.color == color)
            end
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
        gameplay
    end

    def gameplay

        while true
            ['white','black'].each do |player|
                draw_board
                while true
                    start, finish = get_input(player)
                    if test_input(start, finish, player)
                        unless check(player)
                            start_space = Board.find_space(start)
                            finish_space = Board.find_space(finish)
                            move_piece(start_space, finish_space)
                            break
                        end
                    else
                        puts "That is not a legal move"
                    end
                end
                    
                (player == 'white')? (color = 'black') : (color = 'white')
                return if checkmate(check(color), color)

            end
        end
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
        8.times do |y|
            line = ''
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
    end

    def move_piece(start, finish)
        finish.piece = start.piece
        start.delete
        finish.piece.move
    end


    def get_input(player)
        # INPUT: none
        # OUTPUT: 2 part string array, first part the space the player wants move from, second
        # part the splace the player wants to move to.
        while true
            puts "#{player} what space would you like to move and where"
            puts "input in the format <space_name> to <space_name>"
            puts "example: a2 to a3"
            input= gets.chomp
            check = input.scan(/(\w)(\d) to (\w)(\d)/).flatten
            start_string = check[0] + check[1]
            finish_string = check[2] + check[3]
            start = Board.find_space(start_string)
            finish = Board.find_space(finish_string)
            return start, finish if check.length == 4
            puts "what you have entered does not have the correct format. Please try again."
        end
    end

    def test_input(start, finish, player)
        # INPUT: start = string, name of starting space finish = string, name of ending space
        # OUTPUT: returns false if it is not a legal move

        piece = start.piece

        return false unless piece.color == player

        if piece.name.include?  "pawn"
            return pawn_move(start, finish)
        elsif piece.name.include?  "rook"
            return rook_move(start, finish)
        elsif piece.name.include?  "knight"
            return knight_move(start, finish)
        elsif piece.name.include?  "bishop"
            return bishop_move(start, finish)
        elsif piece.name.include?  "queen"
            return queen_move(start, finish)
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
        # INPUT: start = starting space, finish = ending space
        # OUTPUT: boolean if it is a legal move
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
 
        x_dist = (start.x - finish.x).abs + 1
        y_dist = (start.y - finish.y).abs + 1
        piece_path = []

        if x_dist == 0
            (start.y..finish.y).each do |y|
                piece_path <<  Board.find_space_at(start.x, start.y + y)
            end
        elsif y_dist == 0
            (start.x..finish.x).each do |x|
                piece_path <<  Board.find_space_at(start.x + x, start.y)
            end
        elsif y_dist.abs == x_dist.abs
            (start.x - finish.x  >= 0)? (x_move = -1) : (x_move = 1)
            (start.y - finish.y >= 0)? (y_move = -1) : (y_move = 1)
            num = x_dist.abs
            num.times do |move|
                piece_path <<  Board.find_space_at(start.x + x_move * move, start.y + y_move*move)
            end
            
        else 
            return false
        end

        piece_path.each_with_index do |space, index|
            if (index != 0) && (index != piece_path.length + 1)
                if space.piece != nil
                    return false 
                end
            end
        end
        
        true
    end 

    def check(color)
        #INPUTS: color
        #OUTPUTS: space that has king in check, or false

        # if the player moves the piece from its current position to the new position, will the king be vulnerable to attack?
        king = Board.find_piece('king', color)

        if color == 'white'
            pieces = Piece.get_black_pieces
            check_color = 'black'
        else
            pieces = Piece.get_white_pieces
            check_color = 'white'
        end


        pieces.each do |piece|
            space = Board.find_piece(piece.name, check_color)
            if test_input(space, king, check_color)
                puts 'game over'
                return space 
            end
        end

        false
    end

    def checkmate(check_space, color)
        #Input: space that has king in check, color of attacking player
        #output: boolean if game is over or now
        return false if check_space == false
        start = check_space
        finish = Board.find_piece('king', color)
        x_dist = start.x - finish.x
        (color == 'white')? (y_dist = finish.y - start.y) : (y_dist = start.y - finish.y)
        piece_path = []
        if x_dist == 0
            (start.y..finish.y).each do |y|
                piece_path <<  Board.find_space_at(start.x, y)
            end
        elsif y_dist == 0
            (start.x..finish.x).each do |x|
                piece_path <<  Board.find_space_at(x, start.y)
            end
        elsif y_dist.abs == x_dist.abs
            (start.x..finish.x).each do |x|
                piece_path <<  Board.find_space_at(x, start.y + (x - start.x))
            end
        end

        if color == 'white'
            pieces = Piece.get_white_pieces
        else
            pieces = Piece.get_black_pieces
        end

        pieces.each do |piece|
            check = Board.find_piece(piece.name, color)
            piece_path.each do |space|
                return false if test_input(check, space, color)
            end
        end

        true
    end
end

new_game = Chess.new