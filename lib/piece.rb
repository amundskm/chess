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