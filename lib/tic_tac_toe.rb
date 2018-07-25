class TicTacToe
  def WIN_COMBINATIONS
    @WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
  end

  def won?(board)
    WIN_COMBINATIONS.detect do |set|
      board[set[0]] == board[set[1]] &&
      board[set[1]] == board[set[2]] &&
      position_taken?(board, set[0])
    end
  end

  def full?(board)
    board.all?{|marker| marker == "X" || marker == "O"}
  end

  def draw?(board)
    !won?(board) && full?(board)
  end

  def over?(board)
    won?(board) || draw?(board)
  end

  def turn(board)
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
  end

  def position_taken?(board, index)
    board[index]== "X" || board[index] == "O"
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def move(board, index, player)
    board[index] = player
  end

  def winner(board)
    if winning_combo = won?(board)
      board[winning_combo.first]
    end
  end

  def play(board)
    while !over?(board)
      turn(board)
    end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end
end
