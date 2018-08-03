class Board
    #create a chess board, each space has a name, coordiates, and a piece
    attr_accessor :piece, :children
    attr_reader :name, :x, :y, :color



    def initialize(name, x, y, color)
        @name = name
        @x = x
        @y = y
        @piece = nil
        @children = []
        @color = color
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
end