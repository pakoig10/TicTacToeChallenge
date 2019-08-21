def printBoard(dimensions, board)
    column = 0
    while column < dimensions
        print ' '
        ((dimensions * column)...((column + 1) * dimensions)).each { print '___' }
        print "\n", ' '
        ((dimensions * column)...((column + 1) * dimensions)).each { |i| print "|#{board[i]}|" }
        print "\n"
        column += 1
    end
end

def verification(moves, board, player)
    v = false
    while v == false
        if board[moves.to_i] == ' '
            return moves
        elsif player == 1
            print '1st Player writes the position:'
            moves = gets.chomp
        elsif player == 2
            print '2nd Player writes the position:'
            moves = gets.chomp
        end
    end
end

def tryA(try_again)
    while try_again != 'yes' && try_again != 'no'
        print 'Would you want to try again? '
        try_again = gets.chomp.downcase
    end
    try_again
end


def decide(board, player, dimensions)
    flagID = 0
    for row in 1..dimensions do
        flagH = 0
        for section in (dimensions * (row - 1))..((dimensions * row) - 1) do
            flagH += 1 if board[section] == player
            flagV = 0
            dm_v = 0
            if row == 1
                dimensions.times do
                    flagV += 1 if board[section + dm_v] == player
                    dm_v += dimensions
                end
            end

            flagD = 0
            dm_d = 0
            dimensions.times do
                flagD += 1 if board[section + dm_d] == player
                dm_d += dimensions + 1
            end
            return player if flagD == dimensions || flagV == dimensions

        end

        return player if flagH == dimensions

        flagID += 1 if board[(dimensions - 1) * row] == player

        return player if flagID == dimensions

    end
    'n'
end

def welcome(player1)
    puts 'Tic Tac Toe Game'
    if player1 == 'x'
        puts '1st Player use the Cross', '2nd Player use the Naught'
    elsif player1 == 'o'
        puts '1st Player use the Naught', '2nd Player use the Cross'
    end
    dimensions = 0
    while dimensions < 3
        print 'Insert the dimensions(N x N): '
        dimensions = gets.chomp.to_i
        puts "\n"
        if dimensions < 3
            dimensions = 0
        end
    end
    puts "These are the positions(0-#{(dimensions * dimensions) - 1}): \n"
    board = Array.new(dimensions * dimensions, ' ')
    printBoard(dimensions, board)
    puts "\n" + "Let's play! \n \n"
    dimensions
end

player1 = 'x'
player2 = 'o'
try_again = ' '

while try_again != 'no'
    try_again = ' '
    dimensions = welcome(player1)
    moves = Array.new((dimensions * dimensions), 0)
    board = Array.new((dimensions * dimensions), ' ')
    winner = 'n'
    turn = 0

    while winner == 'n'
        print '1st Player writes the position:'
        move = gets.chomp
        move = verification(move, board, 1)
        board[move.to_i] = player1
        moves[turn] = 1
        winner = decide(board, player1, dimensions)
        printBoard(dimensions, board)

        if winner != player1
            turn += 1
            print '2nd Player writes the position:'
            move = gets.chomp
            move = verification(move, board, 2)
            board[move.to_i] = player2
            moves[turn] = 1
            winner = decide(board, player2, dimensions)
            printBoard(dimensions, board)
            turn += 1
        end

        if winner == player1
            puts "\n1st player won"
            playerClone = player1
            player1 = player2
            player2 = playerClone
            try_again = tryA(try_again)
            puts "\n"
        elsif winner == player2
            puts "\n2nd player won"
            try_again = tryA(try_again)
            puts "\n"
        elsif turn == ((dimensions * dimensions) - 1)
            puts 'Draw'
            playerClone = player1
            player1 = player2
            player2 = playerClone
            try_again = tryA(try_again)
            puts "\n"
        end
    end
end
