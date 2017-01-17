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

def is_valid_hand?(cards, expected)
  if are_cards?(cards)
    count = count_cards(cards)
    print "Please enter #{expected} #{singular_or_plural(expected, 'card')}: " unless count == expected
  end

  count == expected
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

def clean_input(cards)
  i = 0
  formatted_hand = []

  until cards[i] == nil
    if cards[i].upcase =~ /[AKQJ2-9]/
      add_card(cards[i].upcase, formatted_hand)

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

def find_hand_type(hand)
  if hand[0] == hand[1]
    'pair'

  elsif hand.include?('A')
    'soft hand'

  else
    'hard hand'

  end
end

def find_value(hand)
  hand_value = 0
  hand.each do |card|
    if card =~ /[KQJ]/
      hand_value += 10

    elsif card == 'A'
      hand_value += 11
    else
      hand_value += card.to_i
    end
  end

  hand_value
end

def get_suggestion(hand_type, hand_value, dealer_card)
  case hand_type
  when 'hard hand'
    convert_advice_code(get_hard_hand_code(hand_value, dealer_card))

  when 'soft hand'
    convert_advice_code(get_soft_hand_code(hand_value, dealer_card))

  when 'pair'
    convert_advice_code(get_pair_code(hand_value, dealer_card))
  end
end

def get_hard_hand_code(hand_value, dealer_card)
  hard_hand = { 5 => {2 => 'H', 3 => 'H', 4 => 'H', 5 => 'H',
                      6 => 'H', 7 => 'H', 8 => 'H', 9 => 'H',
                      10 => 'H', 11 => 'H'},

                6 => {2 => 'H', 3 => 'H', 4 => 'H', 5 => 'H',
                      6 => 'H', 7 => 'H', 8 => 'H', 9 => 'H',
                      10 => 'H', 11 => 'H'},

                7 => {2 => 'H', 3 => 'H', 4 => 'H', 5 => 'H',
                       6 => 'H', 7 => 'H', 8 => 'H', 9 => 'H',
                       10 => 'H', 11 => 'H'},

                8 => {2 => 'H', 3 => 'H', 4 => 'H', 5 => 'Dh',
                      6 => 'Dh', 7 => 'H', 8 => 'H', 9 => 'H',
                      10 => 'H', 11 => 'H'},

                9 => {2 => 'Dh', 3 => 'Dh', 4 => 'Dh', 5 => 'Dh',
                      6 => 'Dh', 7 => 'H', 8 => 'H', 9 => 'H',
                      10 => 'H', 11 => 'H'},

                10 => {2 => 'Dh', 3 => 'Dh', 4 => 'Dh', 5 => 'Dh',
                      6 => 'Dh', 7 => 'Dh', 8 => 'Dh', 9 => 'Dh',
                      10 => 'H', 11 => 'H'},

                11 => {2 => 'Dh', 3 => 'Dh', 4 => 'Dh', 5 => 'Dh',
                      6 => 'Dh', 7 => 'Dh', 8 => 'Dh', 9 => 'Dh',
                      10 => 'Dh', 11 => 'Dh'},

                12 => {2 => 'H', 3 => 'H', 4 => 'S', 5 => 'S',
                      6 => 'S', 7 => 'H', 8 => 'H', 9 => 'H',
                      10 => 'H', 11 => 'H'},

                13 => {2 => 'S', 3 => 'S', 4 => 'S', 5 => 'S',
                      6 => 'S', 7 => 'H', 8 => 'H', 9 => 'H',
                      10 => 'H', 11 => 'H'},

                14 => {2 => 'S', 3 => 'S', 4 => 'S', 5 => 'S',
                      6 => 'S', 7 => 'H', 8 => 'H', 9 => 'H',
                      10 => 'H', 11 => 'H'},

                15 => {2 => 'S', 3 => 'S', 4 => 'S', 5 => 'S',
                      6 => 'S', 7 => 'H', 8 => 'H', 9 => 'H',
                      10 => 'H', 11 => 'H'},

                16 => {2 => 'S', 3 => 'S', 4 => 'S', 5 => 'S',
                      6 => 'S', 7 => 'H', 8 => 'H', 9 => 'H',
                      10 => 'H', 11 => 'H'},

                17 => {2 => 'S', 3 => 'S', 4 => 'S', 5 => 'S',
                      6 => 'S', 7 => 'S', 8 => 'S', 9 => 'S',
                      10 => 'S', 11 => 'S'},

                18 => {2 => 'S', 3 => 'S', 4 => 'S', 5 => 'S',
                      6 => 'S', 7 => 'S', 8 => 'S', 9 => 'S',
                      10 => 'S', 11 => 'S'},

                19 => {2 => 'S', 3 => 'S', 4 => 'S', 5 => 'S',
                      6 => 'S', 7 => 'S', 8 => 'S', 9 => 'S',
                      10 => 'S', 11 => 'S'},

                20 => {2 => 'S', 3 => 'S', 4 => 'S', 5 => 'S',
                      6 => 'S', 7 => 'S', 8 => 'S', 9 => 'S',
                      10 => 'S', 11 => 'S'},

                21 => {2 => 'S', 3 => 'S', 4 => 'S', 5 => 'S',
                      6 => 'S', 7 => 'S', 8 => 'S', 9 => 'S',
                      10 => 'S', 11 => 'S'}}

  hard_hand[hand_value][dealer_card]
end

def get_soft_hand_code(hand_value, dealer_card)
  soft_hand = { 13 => {2 => 'H', 3 => 'H', 4 => 'Dh', 5 => 'Dh',
                       6 => 'Dh', 7 => 'H', 8 => 'H', 9 => 'H',
                       10 => 'H', 11 => 'H'},

                14 => {2 => 'H', 3 => 'H', 4 => 'Dh', 5 => 'Dh',
                       6 => 'Dh', 7 => 'H', 8 => 'H', 9 => 'H',
                       10 => 'H', 11 => 'H'},

                15 => {2 => 'H', 3 => 'H', 4 => 'Dh', 5 => 'Dh',
                       6 => 'Dh', 7 => 'H', 8 => 'H', 9 => 'H',
                       10 => 'H', 11 => 'H'},

                16 => {2 => 'H', 3 => 'H', 4 => 'Dh', 5 => 'Dh',
                       6 => 'Dh', 7 => 'H', 8 => 'H', 9 => 'H',
                       10 => 'H', 11 => 'H'},

                17 => {2 => 'Dh', 3 => 'Dh', 4 => 'Dh', 5 => 'Dh',
                       6 => 'Dh', 7 => 'H', 8 => 'H', 9 => 'H',
                       10 => 'H', 11 => 'H'},

                18 => {2 => 'S', 3 => 'Ds', 4 => 'Ds', 5 => 'Ds',
                      6 => 'Ds', 7 => 'S', 8 => 'S', 9 => 'H',
                      10 => 'H', 11 => 'S'},

                19 => {2 => 'S', 3 => 'S', 4 => 'S', 5 => 'S',
                      6 => 'Ds', 7 => 'S', 8 => 'S', 9 => 'S',
                      10 => 'S', 11 => 'S'},

                20 => {2 => 'S', 3 => 'S', 4 => 'S', 5 => 'S',
                      6 => 'S', 7 => 'S', 8 => 'S', 9 => 'S',
                      10 => 'S', 11 => 'S'},

                21 => {2 => 'S', 3 => 'S', 4 => 'S', 5 => 'S',
                      6 => 'S', 7 => 'S', 8 => 'S', 9 => 'S',
                      10 => 'S', 11 => 'S'}}

  soft_hand[hand_value][dealer_card]
end

def get_pair_code(hand_value, dealer_card)
  pair = {    4 => {2 => 'P', 3 => 'P', 4 => 'P', 5 => 'P',
                      6 => 'P', 7 => 'P', 8 => 'H', 9 => 'H',
                      10 => 'H', 11 => 'H'},

                6 => {2 => 'P', 3 => 'P', 4 => 'P', 5 => 'P',
                      6 => 'P', 7 => 'P', 8 => 'P', 9 => 'H',
                      10 => 'H', 11 => 'H'},

                8 => {2 => 'H', 3 => 'H', 4 => 'P', 5 => 'P',
                       6 => 'P', 7 => 'H', 8 => 'H', 9 => 'H',
                       10 => 'H', 11 => 'H'},

                10 => {2 => 'Dh', 3 => 'Dh', 4 => 'Dh', 5 => 'Dh',
                      6 => 'Dh', 7 => 'Dh', 8 => 'Dh', 9 => 'Dh',
                      10 => 'H', 11 => 'H'},

                12 => {2 => 'P', 3 => 'P', 4 => 'P', 5 => 'P',
                      6 => 'P', 7 => 'P', 8 => 'H', 9 => 'H',
                      10 => 'H', 11 => 'H'},

                14 => {2 => 'P', 3 => 'P', 4 => 'P', 5 => 'P',
                      6 => 'P', 7 => 'P', 8 => 'P', 9 => 'H',
                      10 => 'S', 11 => 'H'},

                16 => {2 => 'P', 3 => 'P', 4 => 'P', 5 => 'P',
                      6 => 'P', 7 => 'P', 8 => 'P', 9 => 'P',
                      10 => 'P', 11 => 'P'},

                18 => {2 => 'P', 3 => 'P', 4 => 'P', 5 => 'P',
                      6 => 'P', 7 => 'S', 8 => 'P', 9 => 'P',
                      10 => 'S', 11 => 'S'},

                20 => {2 => 'S', 3 => 'S', 4 => 'S', 5 => 'S',
                      6 => 'S', 7 => 'S', 8 => 'S', 9 => 'S',
                      10 => 'S', 11 => 'S'},

                22 => {2 => 'P', 3 => 'P', 4 => 'P', 5 => 'P',
                      6 => 'P', 7 => 'P', 8 => 'P', 9 => 'P',
                      10 => 'P', 11 => 'P'}}

  pair[hand_value][dealer_card]
end

def convert_advice_code(advice_code)
  case advice_code
  when 'H'
    'Hit.'
  when 'S'
    'Stand.'
  when 'P'
    'Split.'
  when 'Dh'
    'Double if possible, otherwise Hit.'
  when 'Ds'
    'Double if possible, otherwise Stand.'
  end
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

hand = get_user_hand
dealer_card = get_dealer_card

hand = clean_input(hand)
dealer_card = find_value(clean_input(dealer_card))
hand_type = find_hand_type(hand)
hand_value = find_value(hand)

puts 'You should ' + get_suggestion(hand_type, hand_value, dealer_card)
