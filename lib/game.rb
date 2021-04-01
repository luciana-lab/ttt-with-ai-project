class Game

    #provides access to the board
    #provides access to player_1
    #provides access to player_2
    attr_accessor :board, :player_1, :player_2

    #defines a constant WIN_COMBINATIONS with arrays for each win combination
    WIN_COMBINATIONS = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5,8 ],
        [0, 4, 8], [2, 4, 6]
    ]

    #accepts 2 players and a board
    #defaults to two human players, X and O, with an empty board
    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
    end

    #returns the correct player, X, for the third move
    def current_player
        @board.turn_count % 2 == 0 ? player_1 : player_2
    end
    #if the turn_count divided by 2 is iguals iguals 0 it's player_1's turn, if it's not then it's player_2 turn

    #returns false for a draw
    #returns the correct winning combination in the case of a win
    #isn't hard-coded
    def won?    
        WIN_COMBINATIONS.detect do |win_combo|
            board.cells[win_combo[0]] == board.cells[win_combo[1]] &&
            board.cells[win_combo[1]] == board.cells[win_combo[2]] &&
            board.cells[win_combo[0]] == board.cells[win_combo[2]] &&
            (board.cells[win_combo[0]] == "X" || board.cells[win_combo[0]] == "O")
        end
    end

    #returns true for a draw
    #returns false for a won game
    #returns false for an in-progress game
    def draw?
        board.full? && !won?
    end

    #returns true for a draw
    #returns true for a won game
    #returns false for an in-progress game
    def over?
        draw? || won?
    end

    #returns X when X won
    #returns O when O won
    #returns nil when no winner
    def winner
        if  win_combo = won?
            board.cells[win_combo.first]
        end
    end

    #makes valid moves
    #asks for input again after a failed validation
    #changes to player 2 after the first turn
    def turn
        user_input = current_player.move(board)
        if board.valid_move?(user_input)
            board.update(user_input, current_player)
        else 
            board.display
            turn
        end
    end

    #asks for players input on a turn of the game
    #checks if the game is over after every turn
    #plays the first turn of the game
    #plays the first few turns of the game
    #checks if the game is won after every turn
    #checks if the game is a draw after every turn
    #stops playing if someone has won
    #congratulates the winner X
    #congratulates the winner O
    #stops playing in a draw
    #prints "Cat's Game!" on a draw
    #plays through an entire game
    def play
        turn until over?
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end

end