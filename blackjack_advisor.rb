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
      is_a_card = card.downcase =~ /[akqj1-9 ]/
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

hard_hand = {}
soft_hand = {}
pair = {}

print 'Enter your two cards: '
until is_valid_hand?(hand = gets.chomp, 2)

end

print "Enter the dealer's card: "
until is_valid_hand?(dealer = gets.chomp, 1)

end
