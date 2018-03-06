class Blackjack

	def initialize()
	    @deck 				= Array.new
	    @dealer_cards 		= Array.new
	    @dealer_cards_value = Integer
	    @player_cards 		= Array.new
	    @player_cards_value = Integer
		@faces 				= ['Jack', 'Queen', 'King']	    
	    
	    create_deck()
	    @deck = @deck.shuffle
	end

  	def create_deck()
  		suits = ['Clubs', 'Diamonds', 'Hearts', 'Spades']

  		suits.each {
  			|suit|
  			for i in 2..10
        		@deck.push(i.to_s + ' of ' + suit)
      		end

      		@deck.push('Ace of ' + suit)

      		@faces.each{
      			|face|
      			@deck.push(face + ' of ' + suit)
      		}
  		}
  		return true
  	end


  	def start()
  		deal()
  		show()
  		play()
  		dealer_play()
  		settle()
  		restart()
  		return true
  	end

  	def restart()
  		puts
  		puts "///////////////////"
  		puts
		puts "New deal? yes/no"
		puts '> '
		hit = $stdin.gets.chomp
		
		if hit.downcase != 'yes' && hit != 'no'
			puts 'error: invalid response'
			restart()
			return false
		end

		if hit.downcase == 'yes' 
			@dealer_cards.clear
		    @dealer_cards_value = 0
		    @player_cards.clear
		    @player_cards_value = 0

		    if @deck.count < 4
		    	puts '... reshuffling'
		    	@deck.clear
		    	create_deck()
	    		@deck = @deck.shuffle
	    		puts
				puts "Press enter key to continue"
				$stdin.gets
		    end

			start()
		else
			puts 
			puts 'Thank you for playing!'
		end

		return true
  	end

  	def settle()
  		puts
		puts "Press enter key to show result"
		$stdin.gets
  		puts "Your cards"
  		puts @player_cards
  		puts "Total: " + @player_cards_value.to_s
  		puts
  		if @player_cards_value > 21
  			puts "You lost!"
		else
			puts "Dealer's cards"
	  		puts @dealer_cards
	  		puts "Total: " + @dealer_cards_value.to_s	
	  		puts
	  		if @dealer_cards_value > 21
	  			puts "You win!"
  			elsif @dealer_cards_value > @player_cards_value
  				puts "You lost!"	
			elsif @dealer_cards_value < @player_cards_value
  				puts "You win!"	
			else
				puts "Draw!"
  			end
  		end
  		return true
	end


  	def deal()
  		@player_cards.push(@deck.shift)
  		@dealer_cards.push(@deck.shift)
  		@player_cards.push(@deck.shift)
  		@dealer_cards.push(@deck.shift)
		return true
  	end

  	def show()
  		puts
  		puts 'Your cards:'
  		puts @player_cards
  		set_player_cards_value()
  		puts "Total: " + @player_cards_value.to_s
  		puts
		puts "Press enter key to continue"
		$stdin.gets

  		puts "Dealer's cards"
  		puts @dealer_cards.at(0)
  		puts "_ _ _ _ _ _ _ _ _ "
  		return true
  	end

	def play()

		if @deck.count < 1
			puts
			puts "Deck is finished"		
			return true
		end
		
		puts
		puts "Hit another card? yes/no"
		puts '> '
		hit = $stdin.gets.chomp
		
		if hit.downcase != 'yes' && hit != 'no'
			puts 'error: invalid response'
			play()
			return false
		end

		if hit.downcase === 'yes'
			new_card = @deck.shift
			@player_cards.push(new_card)
			puts
			puts "You got " + new_card
		end

		set_player_cards_value()

		return true
	end

	def set_player_cards_value()
		count = compute_cards(@player_cards)
		total_count = count.at(0)
		ace_count 	= count.at(1)

		if (total_count > 21 && ace_count > 0)
			total_count = evaluate_ace(total_count, ace_count)
		end
		
		@player_cards_value = total_count
	end

	def evaluate_ace(total_count, ace_count)
		i = 1
		while i <= ace_count
		  	total_count -= 10
      		if total_count < 22
      			break
      		end
      		i += 1
		end

		return total_count
	end

	def dealer_take_card()
		if @deck.count < 1
			return false
		end

		@dealer_cards.push(@deck.shift)
		puts
		puts "...dealer takes another card"
		puts
		puts "Press enter key to continue"
		$stdin.gets
		dealer_play()
		return true
	end

	def dealer_play()
		count 		= compute_cards(@dealer_cards)
		total_count = count.at(0)
		ace_count 	= count.at(1)
		
		if total_count < 17
			dealer_take_card()
			return false
		end
		
		if (total_count > 21 && ace_count > 0)
			total_count = evaluate_ace(total_count, ace_count)

			if total_count < 17
				dealer_take_card()
				return false
			end
		end

		@dealer_cards_value = total_count
		return true
	end

	def compute_cards(cards)
		count 		= 0
		ace_count 	= 0

		cards.each {
			|card|
			card_value = card.split(' ')
			if card_value.at(0).downcase == 'ace'
				ace_count 	+= 1
				count 		+= 11
			elsif @faces.include? card_value.at(0)
				count += 10
			else
				count += card_value.at(0).to_i
			end
		}

		return [count, ace_count]
	end

	def set_player_cards(cards)
  		return @player_cards = cards
	end

	def get_player_cards_value()
  		return @player_cards_value
	end

	def set_dealer_cards(cards)
  		return @dealer_cards = cards
	end

	def get_dealer_cards_value()
  		return @dealer_cards_value
	end
end