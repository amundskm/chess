include Math
require "../lib/board.rb"
require "../lib/piece.rb"


class Chess
    attr_accessor :spaces
    @@spaces = []
    def initialize
        Board.empty
        build_board
        build_pieces
        connect_spaces
        gameplay
        
    end

    def add_space(space)
       @@spaces << space
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
                add_space( Board.new(space_name, x ,y, color))
            end
        end
    end

    def find_space(name)
        @@spaces.each { |space| return space  if space.name == name }
        nil
    end

    def find_space_at(x,y)
        @@spaces.each { |space| return space if (space.x == x && space.y == y) }
        nil
    end

    def find_piece(piece, color)
        @@spaces.each { |space| return space  if (space.piece != nil) && (space.piece.name == piece) && (space.piece.color == color) }
        nil
    end


    def build_pieces
        #add white peices to board
        find_space('a1').add_piece(Piece.new('rook1', 'white', '♖'))
        find_space('h1').add_piece(Piece.new('rook2', 'white', '♖'))
        find_space('b1').add_piece(Piece.new('knight1', 'white', '♘'))
        find_space('g1').add_piece(Piece.new('knight2', 'white', '♘'))
        find_space('c1').add_piece(Piece.new('bishop1', 'white', '♗'))
        find_space('f1').add_piece(Piece.new('bishop2', 'white', '♗'))
        find_space('d1').add_piece(Piece.new('queen', 'white', '♕'))
        find_space('e1').add_piece(Piece.new('king', 'white', '♔'))
        8.times do |num|
            letter = (num + 97).chr
            name = letter + 2.to_s
            find_space(name).add_piece(Piece.new('pawn', 'white', '♙'))
        end

        #add black peices to board
        find_space('a8').add_piece(Piece.new('rook1', 'black', '♜'))
        find_space('h8').add_piece(Piece.new('rook2', 'black', '♜'))
        find_space('b8').add_piece(Piece.new('knight1', 'black', '♞'))
        find_space('g8').add_piece(Piece.new('knight2', 'black', '♞'))
        find_space('c8').add_piece(Piece.new('bishop1', 'black', '♝'))
        find_space('f8').add_piece(Piece.new('bishop2', 'black', '♝'))
        find_space('d8').add_piece(Piece.new('queen', 'black', '♛'))
        find_space('e8').add_piece(Piece.new('king', 'black', '♚'))
        8.times do |num|
            letter = (num + 97).chr
            name = letter + 7.to_s
            find_space(name).add_piece(Piece.new('pawn', 'black', '♟'))
        end
    end

    def connect_spaces
        #connect each space with a knights available moves from that space
         @@spaces.each do |space|
            [-1,0,1].each do |x_move|
                [-1,0,1].each do |y_move|
                    #find the nodes that match these coordinates
                    new_x = space.x + x_move
                    new_y = space.y + y_move
                    if find_space_at(new_x, new_y) && (x_move != 0 || y_move != 0)
                        found_nodes =  find_space_at(new_x, new_y).name
                        space.children << found_nodes
                    end

                end
            end
        end
        
    end

    def gameplay
        while true
            ['white', 'black'].each do |player_color|
                draw_board
                start, finish = input(player_color)
                if test_input(start,finish, player_color)
                    move_piece(start, finish)
                end
                (player_color == 'white')? (check_color = 'black') : (check_color = 'white')
                if check(check_color) != false
                    return if checkmate(check(check_color))
                end
            end
        end
    end

    def draw_board
        (7).downto(0) do |y|
            line = "#{y+1}"
            8.times do |x|
                space = find_space_at(x,y)
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

    def input(player)
        while true
            puts "#{player} what space would you like to move and where"
            puts "input in the format '<space_name> to <space_name>'"
            input= gets.chomp
            check = input.scan(/(\w)(\d) to (\w)(\d)/).flatten
            start_string = check[0] + check[1]
            finish_string = check[2] + check[3]
            start = find_space(start_string)
            finish = find_space(finish_string)
            return start, finish if check.length == 4
            puts "what you have entered does not have the correct format. Please try again."
        end
    end

    def test_input(start, finish, color)
        piece = start.piece

        return false unless piece.color == color

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

    def piece_move_vars(start,finish)
        shade = start.piece.color
        x = (start.x - finish.x).abs
        y = (start.y - finish.y).abs
        return shade, x, y
    end

    def find_path(start,finish)
        queue = [start]
        visited = []
        path = []
        while !queue.empty?

            node = queue.delete_at(0)

            if node == finish
                path.pop
                return path 
            end

            short_dist = Math.sqrt((node.x - finish.x) ** 2 + (node.y - finish.y) ** 2)
            short_child = node

            node.children.each do |child|
                child_space = find_space(child)
                if !visited.include?(child_space)
                    dist = Math.sqrt((child_space.x - finish.x) ** 2 + (child_space.y - finish.y) ** 2)

                    if dist < short_dist
                        short_child = child_space
                        short_dist = dist
                    end
                end
                visited << node
            end

            path << short_child
            queue << short_child
        end
    end

    def no_jump(start,finish)
        path = find_path(start, finish)
        path.each {|space| return false if space.piece}
    end

    def pawn_move(start, finish)
        color, x_dist, y_dist = piece_move_vars(start,finish)
        return false if (color == 'white') && (start.y - finish.y > 0)
        return false if (color == 'black') && (start.y - finish.y < 0)
        return true if (x_dist == 1) && (y_dist == 1) && (finish.piece.color != color)
        return true if (x_dist == 0) && (y_dist == 2) && (no_jump(start,finish)) && (finish.piece == nil) && (start.piece.num_moves == 0)
        return true if (x_dist == 0) && (y_dist == 1) && (finish.piece == nil)
        return false
    end

    def rook_move(start, finish)
        color, x_dist, y_dist = piece_move_vars(start,finish)
        return true if (x_dist == 0) && no_jump(start, finish) && ((finish.piece == nil) ||(finish.piece.color != color))
        return true if (y_dist == 0) && no_jump(start, finish) && ((finish.piece == nil) ||(finish.piece.color != color))
        return false
    end

    def bishop_move(start, finish)
        color, x_dist, y_dist = piece_move_vars(start,finish)
        return true if (x_dist == y_dist) && no_jump(start, finish) && ((finish.piece == nil) ||(finish.piece.color != color))
        return false
    end

    def knight_move(start, finish)
        color, x_dist, y_dist = piece_move_vars(start,finish)
        return true if (x_dist + y_dist == 3) && (x_dist <= 2) && (y_dist <= 2) && ((finish.piece == nil) ||(finish.piece.color != color))
        return false
    end

    def king_move(start, finish)
        color, x_dist, y_dist = piece_move_vars(start,finish)
        return true if (x_dist <= 1) && (y_dist <= 1) && ((finish.piece == nil) ||(finish.piece.color != color))
        return false

    end

    def queen_move(start, finish)
        color, x_dist, y_dist = piece_move_vars(start,finish)
        return true if (x_dist == 0) && no_jump(start, finish) && ((finish.piece == nil) ||(finish.piece.color != color))
        return true if (y_dist == 0) && no_jump(start, finish) && ((finish.piece == nil) ||(finish.piece.color != color))
        return true if (x_dist == y_dist) && no_jump(start, finish) && ((finish.piece == nil) ||(finish.piece.color != color))
        return false
    end

    def move_piece(start, finish)
        finish.piece = start.piece
        start.delete
        finish.piece.move
    end

    def check(color)
       if color == 'white'
            pieces = Piece.get_black_pieces 
            enemy_color = 'black'
        else
            pieces = Piece.get_white_pieces
            enemy_color = 'white'
        end
        king_space = find_piece('king', color)
        pieces.each do |piece|
            space = find_piece(piece.name, enemy_color)
            return space if test_input(space, king_space, enemy_color)
        end
        return false
    end

    def checkmate(enemy_check)
        (enemy_check.piece.color == 'white')?  (color = 'black') : (color = 'white')
        (color == 'white')? (pieces = Piece.get_white_pieces) : (pieces = Piece.get_black_pieces)
        king_space = find_piece('king', color)
        #can the king move out of the path?
        [-1, 0, 1].each do |x|
            [-1, 0, 1].each do |y|
                new_space = find_space_at(king_space.x + x, king_space.y + y)
                if test_input(king_space, new_space, color)
                    move_piece(king_space, new_space)
                    if check(color) == false
                        move_piece(new_space, king_space)
                        return false
                    else
                        move_piece(new_space, king_space)
                    end
                end 
            end
        end

        #can another piece move into the path
        path = find_path(enemy_check, king_space)
        path << enemy_check
        path.each do |path_space|
            pieces.each do |piece|
                space = find_piece(piece.name, color)
                if test_input(space, path_space, color)
                    move_piece(space, path_space)
                    if check(color) == false
                        move_piece(path_space, space)
                        return false
                    else
                        move_piece(path_space, space)
                    end
                end
            end
        end

        true
    end
                    

end

 new_game = Chess.new
# new_game.build_board
# new_game.build_pieces
# new_game.connect_spaces
# start = find_space('a1')
# finish = find_space('e5')
# get_path = new_game.find_path(start, finish)
# get_path.each { |space| puts space.name}
