module Players

    #inherits from Player
    class Human < Player

        #asks the user for input and returns it
        def move(input)
            input = gets.strip
        end

    end
end