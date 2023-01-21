# Create TicTacToe class with methods allowing a game to be played
class TicTacToe
  attr_accessor :player1, :player2, :board

  # Initialize players and starting board
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = %w[1 2 3 4 5 6 7 8 9]
  end

  # Format and display the tic-tac-toe board
  def display_board
    puts " #{board[0]} | #{board[1]} | #{board[2]}"
    puts '---+---+---'
    puts " #{board[3]} | #{board[4]} | #{board[5]}"
    puts '---+---+---'
    puts " #{board[6]} | #{board[7]} | #{board[8]}"
  end

  # Update board with player char
  def update_board(char, location)
    board[location] = char
  end

  # Determine whether a winner exists
  def winner?
    # Check for horizontal combinations
    return board[0] if board[0] == board[1] && board[0] == board[2]
    return board[3] if board[3] == board[4] && board[3] == board[5]
    return board[6] if board[6] == board[7] && board[6] == board[8]
    # Check for vertical combinations
    return board[0] if board[0] == board[3] && board[0] == board[6]
    return board[1] if board[1] == board[4] && board[1] == board[7]
    return board[2] if board[2] == board[5] && board[2] == board[8]
    # Check for diagonal combinations
    return board[0] if board[0] == board[4] && board[0] == board[8]
    return board[2] if board[2] == board[4] && board[2] == board[6]

    # Check if no winner exists
    false
  end

  # Determine whether the board is complete
  def board_complete?
    %w[1 2 3 4 5 6 7 8 9].select { |value| board.include?(value) }.none?
  end

  # Play a game of tic-tac-toe
  def play_game
    turn = 1

    # Repeat until winner is determined or board is completed
    loop do
      system('clear')
      display_board

      # Add space between board and prompt
      puts

      if turn.odd?
        print "#{player1.name}'s turn (Choose location on board): "
        # Subtract to get proper index value
        choice = gets.chomp.to_i - 1

        # Skip to next iteration if choice is already taken
        next if board[choice] == player1.char || board[choice] == player2.char

        update_board(player1.char, choice)
        # Switch turns
        turn += 1
      else
        print "#{player2.name}'s turn (Choose location on board): "
        # Subtract to get proper index value
        choice = gets.chomp.to_i - 1

        # Skip to next iteration if choice is already taken
        next if board[choice] == player1.char || board[choice] == player2.char

        update_board(player2.char, choice)
        # Switch turns
        turn -= 1
      end

      # If winner is found, print their name and break from loop
      if winner?
        system('clear')
        display_board
        puts
        puts winner? == player1.char ? "#{player1.name} wins!" : "#{player2.name} wins!"
        break
      end

      # If board is complete, declare tie and break from loop
      if board_complete?
        system('clear')
        display_board
        puts
        puts 'You both tie!'
        break
      end
    end
  end
end

# Create class to represent players
class Player
  attr_accessor :win_count
  attr_reader :char, :name

  def initialize(name, char)
    @name = name
    @char = char
    @win_count = 0
  end
end

print 'Player 1 name: '
player1 = Player.new(gets.chomp, 'X')
print 'Player 2 name: '
player2 = Player.new(gets.chomp, 'O')

tic_tac_toe = TicTacToe.new(player1, player2)
tic_tac_toe.play_game
