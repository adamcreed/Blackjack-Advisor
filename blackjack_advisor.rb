def is_valid_hand?(cards, expected)
  if are_cards?(cards)
    count = count_cards(cards)
    print "Please enter #{expected} #{singular_or_plural(expected, 'card')}: " unless count == expected
  end

  count == expected
end

def clean_input(cards)
  i = 0
  formatted_hand = []

  until cards[i] == nil
    if cards[i].upcase =~ /[AKQJ2-9]/
      add_card(cards[i], formatted_hand)

    elsif cards[i] == '1' and cards[i + 1] == '0'
      add_card('10', formatted_hand)

    end

    i += 1
  end

  formatted_hand
end

def add_card(card, hand)
  hand << card
end

def are_cards?(cards)
  is_a_card = true
  previous = ''
  cards.split("").each do |card|
    if is_a_card
      is_a_card = card.upcase =~ /[AKQJ1-9 ]/
      is_a_card = true if previous == '1' and card == '0'
      is_a_card = false if previous == '1' and not (card == '0')
      previous = card
    end
  end
  is_a_card = false if previous == '1'

  print 'Invalid entry. Cards should be 2-10, j, q, k, or a: ' unless is_a_card

  is_a_card
end

def count_cards(cards)
  count = 0

  cards.split("").each { |card| count += 1 unless card == '0' or card == ' ' }

  count
end

def singular_or_plural(quantity, noun)
  if quantity == 1
    noun
  else

    case noun[-2] + noun[-1]
    when /ch/, /sh/, /.s/, /.x/, /.z/
      noun + 'es'
    when /[aeiou]y/
      noun + 's'
    when /.y/
      noun[0..-2] + 'ies'
    when /.f/
      noun[0..-2] + 'ves'
    when /fe/
      noun[0..-3] + 'ves'
    else
      noun + 's'
    end
  end
end

def get_user_hand
  print 'Enter your two cards: '
  until is_valid_hand?(hand = gets.chomp, 2); end
  #This seems kinda weird, but I don't actully need the loop to do anything except pass
  hand
end

def get_dealer_card
  print "Enter the dealer's card: "
  until is_valid_hand?(dealer_card = gets.chomp, 1); end
  dealer_card
end

def find_hand_type(hand)
  if hand[0] == hand[1]
    'a_pair'

  elsif hand.include?('A')
    'soft_hand'

  else
    'hard_hand'

  end
end

def find_value(hand)
  hand.each do |card|
    if card.upcase =~ /KQJ/
      card = '10'

    elsif card.upcase == 'A'
      card = '11'

    end
  end

  if hand.size == 2
    hand[0] + hand[1]
  else
    hand[0]
  end

end

def get_suggestion(hand_type, hand_value, dealer_card)
  hard_hand = { 5 => {2 => 'Hit', 3 => 'Hit', 4 => 'Hit', 5 => 'Hit',
                      6 => 'Hit', 7 => 'Hit', 8 => 'Hit', 9 => 'Hit',
                      10 => 'Hit', 'A' => 'Hit'},
                6 => {2 => 'Hit', 3 => 'Hit', 4 => 'Hit', 5 => 'Hit',
                      6 => 'Hit', 7 => 'Hit', 8 => 'Hit', 9 => 'Hit',
                      10 => 'Hit', 'A' => 'Hit'},
                7 => {2 => 'Hit', 3 => 'Hit', 4 => 'Hit', 5 => 'Hit',
                       6 => 'Hit', 7 => 'Hit', 8 => 'Hit', 9 => 'Hit',
                       10 => 'Hit', 'A' => 'Hit'},
                8 => {2 => 'Hit', 3 => 'Hit', 4 => 'Hit',
                      5 => 'Double if possible, otherwise Hit',
                      6 => 'Double if possible, otherwise Hit', 7 => 'Hit',
                      8 => 'Hit', 9 => 'Hit', 10 => 'Hit', 'A' => 'Hit'}}
  soft_hand = {}
  a_pair = {}

  case hand_type
  when 'hard_hand'
    hard_hand{hand_value{dealer_card}}

  when 'soft_hand'
    soft_hand{hand_value{dealer_card}}

  when 'pair'
    a_pair{hand_value{dealer_card}}

  end
end

hand = get_user_hand
dealer_card = get_dealer_card

hand = clean_input(hand)
dealer_card = clean_input(dealer_card)
hand_type = find_hand_type(hand)
hand_value = find_value(hand)

puts 'You should ' + get_suggestion(hand_type, hand_value, dealer_card).to_s
