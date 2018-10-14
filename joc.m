function [] = joc()
	pad = {3 2 1; 6 5 4; 9 8 7}; %link between NumPad and board
	game = 0; %games played counter
	scorep = 0; scorec = 0; %scores
	
	disp("Use the NumPad to select your move or press q to quit.")
	
	while(1)
		[dif ok] = listdlg('PromptString', 'Choose the difficulty!', 'ListString', {'Easy' 'Medium' 'Hard'}, 'SelectionMode', 'single');
		
		if(ok == 0)
			break
		endif
	
		[sel ok] = listdlg('PromptString', 'Choose your symbol!', 'ListString', {'X' '0'}, 'SelectionMode', 'single');
		
		if(ok == 0)
			break
		endif
		
		if (sel == 1) %player is X
			p = ' x '; c = ' o '; %p - player; c - comp
		else
			p = ' o '; c = ' x ';
		endif
		
		board = {' - ' ' - ' ' - '; ' - ' ' - ' ' - '; ' - ' ' - ' ' - '};
		opt = [1 3 5 7 9]; %best move options
		winner = 0; %1 - user; 2 - computer; 3 - tie; 0 - no winner yet
		cmove = 0; %computer's move
		move = 0; %user's move
		i = 0;
		
		while ((winner == 0) && (i < 9))
		
			%if comp starts
			if (sel == 2 && i == 0)
				if (dif != 3)
					cmove = floor(1 + 9 * rand(1));
				else
					cmove = opt(floor(1 + 5 * rand(1)));
				endif
				board{cmove} = c; %random option
				i++;
			endif
			
			disp(cell2mat(board));
			prev = move; %save previous move
			
			%get user move
			while(1)
				move = input("\n", "s");
				if (move == 'q' || move == 'Q')
					score = ["Score\nComputer: ", num2str(scorec), "\nPlayer: ", num2str(scorep), "\nGames:", num2str(game)];
					disp(score)
					disp("\nQuitting.")
					return
				elseif isempty(move)
					disp("Invalid move! Please try again.");
					continue
				elseif !all(isstrprop(move, 'digit'))
					disp("Invalid move! Please try again.");
					continue
				else
					move = str2num(move);
					if !any(move == [1:9])
						disp("Invalid move! Please try again.");
						continue
					else
						move = pad{move}; %translates NumPad key to cell array index
						if (strcmp(board{move}, ' - '))
							board{move} = p;
							i++;
							break
						else
							disp("Invalid move! Please try again.");
						endif
					endif
				endif
			endwhile
			
			%displays the board
			disp(cell2mat(board));
			disp("\n");
			
			%if i >= 9 the board is full
			if (i >= 9)
				winner = 3;
				break
			endif

			%for easy and medium mode, check if user won
			if (dif <= 2)
				for m = 1 : 3
					%horizontal lines
					if (strcmp(board{m,1}, p) && strcmp(board{m,2}, p) && strcmp(board{m,3}, p))
						winner = 1;
						scorep++;
						break
					endif
					%vertical lines
					if (strcmp(board{1,m}, p) && strcmp(board{2,m}, p) && strcmp(board{3,m}, p))
						winner = 1;
						scorep++;
						break
					endif
				endfor
				%primary diagonal
				if (strcmp(board{1,1}, p) && strcmp(board{2,2}, p) && strcmp(board{3,3}, p))
					winner = 1;
					scorep++;
					break
				endif
				%secondary diagonal
				if (strcmp(board{1,3}, p) && strcmp(board{2,2}, p) && strcmp(board{3,1}, p))
					winner = 1;
					scorep++;
					break
				endif
				
				if (winner)
					break
				endif
			endif
			
			%comp makes move
			
			%for hard mode, multiple conditions
			if (dif == 3)
				%if user starts
				if (i == 1 && sel == 1)
					if any(move == [1 3 7 9]) %if user picks corner, comp picks center
						cmove = 5; %save computer's move
					else %if user picks center, comp picks corner
						if (move == 5)
							opt = [1 3 7 9];
							cmove = opt(floor(1 + 4 * rand(1)));
						else %if user picks edge, comp picks bordering corner
							if (move == 4)
								opt = [1 7];
							elseif (move == 2)
								opt = [1 3];
							elseif (move == 6)
								opt = [3 9];
							elseif (move == 8)
								opt = [7 9];
							endif
							cmove = opt(floor(1 + 2 * rand(1))); 
						endif
					endif
					board{cmove} = c;
					i++;
					continue %get next move
				endif
				
				%if user started on corner (comp chose center) and chose opposite corner
				if (i == 3 && sel == 1 && cmove == 5)
					if ((prev == 3 && move == 7) || (prev == 7 && move == 3) ||
							(prev == 1 && move == 9) || (prev == 9 && move == 1))
						opt = [2 4 6 8]; %comp chooses edge
						cmove = opt(floor(1 + 4 * rand(1)));
						board{cmove} = c;
						i++;
						continue
					endif
				endif
				
				%if computer started on corner and player chose center
				if (i == 2 && sel == 2 && any(cmove == [1 3 7 9]) && move == 5)
					if (cmove == 1)
						cmove = 9;
					elseif (cmove == 3)
						cmove = 7;
					elseif (cmove == 7)
						cmove = 3;
					elseif (cmove == 9)
						cmove = 1;
					endif
					board{cmove} = c;
					i++;
					continue
				endif
				
				%if computer started on center and player chose corner
				if (i == 2 && sel == 2 && cmove == 5 && any(move == [1 3 7 9]))
					if (move == 1)
						cmove = 9;
					elseif (move == 3)
						cmove = 7;
					elseif (move == 7)
						cmove = 3;
					elseif (move == 9)
						cmove = 1;
					endif
					board{cmove} = c;
					i++;
					continue
				endif
			endif
			
			%except for easy mode
			if (dif >= 2)
				%checks if win is possible
				for m = 1 : 3
					%horizontal lines
					if (strcmp(board{m,1}, c) && strcmp(board{m,1}, board{m,2}) && strcmp(board{m,3},' - '))
						board{m,3} = c;
						winner = 2;
						scorec++;
					elseif (strcmp(board{m,1}, c) && strcmp(board{m,1}, board{m,3}) && strcmp(board{m,2},' - '))
						board{m,2} = c;
						winner = 2;
						scorec++;
					elseif (strcmp(board{m,2}, c) && strcmp(board{m,2}, board{m,3}) && strcmp(board{m,1},' - '))
						board{m,1} = c;
						winner = 2;
						scorec++;
					%vertical lines
					elseif (strcmp(board{1,m}, c) && strcmp(board{1,m}, board{2,m}) && strcmp(board{3,m},' - '))
						board{3,m} = c;
						winner = 2;
						scorec++;
					elseif (strcmp(board{1,m}, c) && strcmp(board{1,m}, board{3,m}) && strcmp(board{2,m},' - '))
						board{2,m} = c;
						winner = 2;
						scorec++;
					elseif (strcmp(board{2,m}, c) && strcmp(board{2,m}, board{3,m}) && strcmp(board{1,m},' - '))
						board{1,m} = c;
						winner = 2;
						scorec++;
					%primary diagonal
					elseif (strcmp(board{m,m}, c) && strcmp(board{m,m},board{nmod(m + 1,3),nmod(m + 1,3)}) && strcmp(board{nmod(m + 2,3),nmod(m + 2,3)},' - '))
						board{nmod(m + 2,3),nmod(m + 2,3)} = c;
						winner = 2;
						scorec++;
					elseif (strcmp(board{m,m}, c) && strcmp(board{m,m},board{nmod(m + 2,3),nmod(m + 2,3)}) && strcmp(board{nmod(m + 1,3),nmod(m + 1,3)},' - '))
						board{nmod(m + 1,3),nmod(m + 1,3)} = c;
						winner = 2;
						scorec++;
					%secondary diagonal
					elseif (strcmp(board{m,4 - m}, c) && strcmp(board{m,4 - m},board{nmod(m - 1,3),nmod(5 - m,3)}) && strcmp(board{nmod(m - 2,3),nmod(6 - m,3)},' - '))
						board{nmod(m - 2,3),nmod(6 - m,3)} = c;
						winner = 2;
						scorec++;
					endif
				endfor
				if (winner)
					break
				endif
					
				%if not, checks if a counterattack is needed
				cpi = i; %copie i
				for m = 1 : 3
					%horizontal lines
					if (strcmp(board{m,1}, p) && strcmp(board{m,1}, board{m,2}) && strcmp(board{m,3}, ' - '))
						board{m,3} = c;
						i++;
					elseif (strcmp(board{m,1}, p) && strcmp(board{m,1}, board{m,3}) && strcmp(board{m,2}, ' - '))
						board{m,2} = c;
						i++;
						break
					elseif (strcmp(board{m,2}, p) && strcmp(board{m,2}, board{m,3}) && strcmp(board{m,1}, ' - '))
						board{m,1} = c;
						i++;
						break
					%vertical lines
					elseif (strcmp(board{1,m}, p) && strcmp(board{1,m}, board{2,m}) && strcmp(board{3,m}, ' - '))
						board{3,m} = c;
						i++;
						break
					elseif (strcmp(board{1,m}, p) && strcmp(board{1,m}, board{3,m}) && strcmp(board{2,m}, ' - '))
						board{2,m} = c;
						i++;
						break
					elseif (strcmp(board{2,m}, p) && strcmp(board{2,m}, board{3,m}) && strcmp(board{1,m}, ' - '))
						board{1,m} = c;
						i++;
						break
					%primary diagonal
					elseif (strcmp(board{m,m}, p) && strcmp(board{m,m},board{nmod(m + 1,3),nmod(m + 1,3)}) && strcmp(board{nmod(m + 2,3),nmod(m + 2,3)}, ' - '))
						board{nmod(m + 2,3),nmod(m + 2,3)} = c;
						i++;
						break
					elseif (strcmp(board{m,m}, p) && strcmp(board{m,m},board{nmod(m + 2,3),nmod(m + 2,3)}) && strcmp(board{nmod(m + 1,3),nmod(m + 1,3)}, ' - '))
						board{nmod(m + 1,3),nmod(m + 1,3)} = c;
						i++;
						break
					%secondary diagonal
					elseif (strcmp(board{m,4 - m}, p) && strcmp(board{m,4 - m},board{nmod(m - 1,3),nmod(5 - m,3)}) && strcmp(board{nmod(m - 2,3),nmod(6 - m,3)}, ' - '))
						board{nmod(m - 2,3),nmod(6 - m,3)} = c;
						i++;
						break
					endif
				endfor
				
				if (cpi != i)
					continue
				endif
			endif
			
			if (dif != 3) %for easy and medium mode, make random move
				while(1)
					cmove = floor(1 + 9 * rand(1));
					if (strcmp(board{cmove}, ' - '))
						board{cmove} = c;
						i++;
						break;
					endif
				endwhile
			else %for hard mode, some moves are prioritary
				for j = [5 1 3 7 9 2 4 6 8]
					if (strcmp(board{j}, ' - '))
						cmove = j;
						board{cmove} = c;
						i++;
						break
					endif
				endfor
			endif
		endwhile
		
		disp(cell2mat(board));
		game++;
		
		if (winner == 1)
			disp("\nCongratulations! You win!\n")
		elseif (winner == 2)
			disp("\nToo bad... You lost.\n")
		else
			disp("\nIt's a tie!\n")
		endif
		
		score = ["Score\nComputer: ", num2str(scorec), "\nPlayer: ", num2str(scorep), "\nGames:", num2str(game)];
		disp(score)
	endwhile
endfunction