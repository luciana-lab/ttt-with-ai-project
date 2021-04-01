class Board

    #has an attribute to store the cells of the board
    attr_accessor :cells

    #can reset the state of the cells in the board
    #sets the cells of the board to a 9 element array of " "
    def reset!
        @cells.clear
        @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    #sets the cells of the board to a 9 element array of " "
    def initialize
        @cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    #prints the board
    def display
        puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
        puts "-----------"
        puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
        puts "-----------"
        puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
    end

    #takes in user input and returns the value of the board cell
    def position(input)
        user_input = input.to_i - 1
        cells[user_input]
    end

    #returns true for a full board
    #returns false for an in-progress game
    def full?
        cells.all? {|token| token == "O" || token == "X"}
        #@cells.to_s.strip.empty?
    end

    #returns the amount of turns based on cell value
    def turn_count
        #@cells.count("X") + @cells.count("O")
        cells.count {|token| token == "X" || token == "O"}
    end

    #returns true if the position is X or O
    #returns false if the position is empty or blank
    def taken?(input)
        !(position(input) == " " || position(input) == "")
        #@cells[position_to_i] == " "

    end

    #returns true for user input between 1-9 that is not taken
    def valid_move?(index)
        !taken?(index) && (1..9).include?(index.to_i)
    end

    #updates the cells in the board with the player token according to the input
    def update(input, player)
        cells[input.to_i - 1] = player.token
    end

end