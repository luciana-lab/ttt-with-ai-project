module Players

    #inherits from Player
    class Computer < Player

        #returns a valid position for the computer to move
        def move(board)
            #position 5 is the best position to take; if it's not taken, choose this position
            if !board.taken?(5)
                "5"
            #on the 1st or 2nd turns, choose the position 1 (one of the corners), if this position is taken, choose the 3rd position
            elsif board.turn_count == 1 || board.turn_count == 2
                if !board.taken?(1)
                    "1"
                else
                    "3"
                end
            #check the win combinations to know if two squares are filled with the same token and a third, empty square
            else
                Game::WIN_COMBINATIONS.detect do |combo|

                    #1. check if there's a change to win
                    if combo.select {|index| board.position(index+1) == token}.size == 2 && combo.any? {|index| board.position(i+1) == " "}
                        move = combo.select {|index| !board.taken?(index+1)}.first.to.i.+(1).to_s

                    #2. if no chance to win, check for a move to don't lose (don't make your opponent a winner)
                    elsif combo.select {|index| board.position(index+1) != " " && board.position(index+1) != token}.size == 2 && combo.any? {|index| board.position(index+1) == " "} 
                        move = combo.select {|index| !board.taken?(index+1)}.first.to_i.+(1).to_s

                    #3. if no chance to win or no move to block the opponent to win, pick the first available spot
                    else
                        move = [1, 3, 7, 9, 2, 4, 6, 8].detect {|index| !board.taken?(index)}.to_s if move == nil
                    end
                end
            end
        end
    end
end

#position 5 is the best position to take

#check the win combinations
#1 win first
#2 not lose
#3 pick the first available spot