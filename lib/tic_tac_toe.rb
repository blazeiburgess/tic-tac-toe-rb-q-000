WIN_COMBINATIONS = [
	[0,1,2],
	[3,4,5],
	[6,7,8],
	[0,3,6],
	[1,4,7],
	[2,5,8],
	[0,4,8],
	[2,4,6]
]

def display_board(board)
	puts " #{ board[0..2].join(" | ")} #{"\n"+"-"*11+"\n"} #{ board[3..5].join(" | ")} #{"\n"+"-"*11+"\n"} #{ board[6..8].join(" | ")} "
end

def move(board, position, character)
	board[position.to_i - 1] = character
	return board
end

def position_taken?(board, location)
  !(board[location].nil? || board[location] == " ")
end

def valid_move?(board, location)
	!(position_taken?(board, location.to_i - 1) || location.to_i.to_s != location)
end

def turn_count(board_array)
	count = 0
	board_array.each do |space|
		if space == "X" || space == "O"
			count += 1
		end
	end
	return count
end

def current_player(board_array)
	count = 0
	board_array.each do |space|
		if space == "X" || space == "O"
			count += 1
		end
	end
	if count % 2 == 0
		return "X"
	else
		return "O"
	end
end

def won?(board)
	winner = false
	WIN_COMBINATIONS.each do |combo|
		winning_combo = board[combo[0]].to_s + board[combo[1]].to_s + board[combo[2]].to_s
		if winning_combo == "XXX" || winning_combo == "OOO"
			return combo
		end
	end
	return winner
end

def full?(board)
	!board.include?(" ")
end

def draw?(board)
	!won?(board) && full?(board)
end

def over?(board)
	full?(board) || draw?(board) || won?(board)
end

def winner(board)
	if won?(board)
		return board[won?(board)[0]]
	else
		return nil
	end
end

def turn(board)
  choice = gets.strip
	if valid_move?(board, choice)
		move(board, choice, current_player(board))
	else
		turn(board)
	end
	display_board(board)
end

def play(board)
	until over?(board)
		puts "Please pick a space 1-9."
		turn(board)
	end
	if won?(board)
		puts "Congratulations #{winner(board)}!"
	elsif draw?(board)
		puts "Cats Game!"
	end
end
