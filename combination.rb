class Combination
  def initialize(hidden, open)
    @hidden = hidden
    @open = open
  end
# Returns the name of combination
  def find_combination
    cards = royal_flush(@hidden, @open)
    unless cards == false
      puts "Royal Flush"
      print cards
      puts
    end
    cards = straight_flush(@hidden, @open)
    unless cards == false
      puts "Straight Flush"
      print cards
      puts
    end
    cards = flush(@hidden, @open)
    unless cards == false
      puts "Flush"
      print cards
      puts
    end
    cards = straight(@hidden, @open)
    unless cards == false
      puts "Straight"
      print cards
      puts
    end
    cards = three_of_a_kind(@hidden, @open)
    unless cards == false
      puts "Three of a Kind"
      print cards
      puts
    end
    cards = two_pairs(@hidden, @open)
    unless cards == false
      puts "Two Pairs"
      print cards
      puts
    end     
    cards = one_pair(@hidden, @open)
    unless cards == false
      puts "One Pair"
      print cards
      puts
    end
  end

  private
  def royal_flush(hidden, open)
    royal_cards = ['T','J','Q','K','A']
    cards = one_color(hidden, open)
    result = []
    if cards == false
      return false
    else
      cards << hidden 
      cards.flatten!
      cards.each_index do |i|
        if i.even?
          return false unless royal_cards.include?(cards[i])
          result << (cards[i]+cards[i+1]).to_s
        end 
      end
    end
    result  
  end

  def straight_flush(hidden, open)
    cards = one_color(hidden, open)
    result = []
    if cards == false
      return false
    else
      cards = sequence(hidden, cards)
      return false if cards == false
      cards << hidden 
      cards.flatten!
      cards.each_index do |i|
        if i.even?
          result << (cards[i]+cards[i+1]).to_s
        end 
      end
    end 
    result
  end

  def four_of_a_kind(hidden, open)
  end

  def full_house(hidden, open)
  end

  def flush(hidden, open)
    cards = one_color(hidden, open)
    one_result = []
    result = []
    new_hidden = []
    new_open = []
    return false if cards == false
      hidden.each_index do |i|
        if i.even?
          new_hidden << (hidden[i]+hidden[i+1]).to_s
        end 
      end
      cards.each_index do |i|
        if i.even?
          new_open << (cards[i]+cards[i+1]).to_s
        end
      end 
      if new_open.size > 3
        one_result << new_hidden
        i = 0
        while i<3
          one_result << new_open[i]
          i += 1
        end
        one_result.flatten!
        result << one_result
        one_result = []
        one_result << new_hidden
        i = 3
        while i>0
          one_result << new_open[i]
          i -= 1
        end
        one_result.flatten!
        result << one_result
      else
        one_result << new_hidden
        one_result << new_open
        one_result.flatten!
        result = one_result
      end
    result   
  end

  def straight(hidden, open)
    result = []
    cards = sequence(hidden, open)
    return false if cards == false
    cards << hidden 
    cards.flatten!
    cards.each_index do |i|
      if i.even?
        result << (cards[i]+cards[i+1]).to_s
      end 
    end 
    result 
  end

  def three_of_a_kind(hidden, open)
    result = []
    i = 0
    j = 0
    check = []
    tmp = 0 
    tmp_j = 0
    open.each_index do |i|
      if i.even?
        if open.count(open[i]) >= 3
          result << (open[i]+open[i+1]).to_s
          check << tmp_j
          check << i
        end
      end
    end 
    unless check == []
      hidden.each_index do |i|
        result << (hidden[i]+hidden[i+1]).to_s if i.even?
      end
    end
    return result
    if open.count(hidden[i]) >= 2
      j = open.index(hidden[i])
      elem = open[j]
      hidden.each_index do |i|
        result << (hidden[i]+hidden[i+1]).to_s if i.even?
      end
      open.each_index do |i|
        result << (open[i]+open[i+1]).to_s if open[i] == elem
        check << i
      end
      open.each_index do |i|
        break if result.size == 5
        next if check.include?(i)
        result << (open[i]+open[i+1]).to_s if i.even?
      end     
    elsif open.count(hidden[i+2]) >= 2 
      j = open.index(hidden[i+2]) 
      elem = open[j+2]
      hidden.each_index do |i|
        result << (hidden[i]+hidden[i+1]).to_s if i.even?
      end
      open.each_index do |i|
        result << (open[i]+open[i+1]).to_s if open[i] == elem
        check << i
      end
      open.each_index do |i|
        break if result.size == 5
        next if check.include?(i)
        result << (open[i]+open[i+1]).to_s if i.even?
      end  
    elsif hidden[i] == hidden[i+2] && open.count(hidden[i]) >= 1
      j = open.index(hidden[i])
      result << (open[j]+open[j+1]).to_s
      check << j
      open.each_index do |i|
        break if result.size == 5
        next if check.include?(i)
        result << (open[i]+open[i+1]).to_s if i.even?
      end
      hidden.each_index do |i|
        result << (hidden[i]+hidden[i+1]).to_s if i.even?
      end
    else
      return false
    end
    result  
  end

  def two_pairs(hidden, open)
    result = []
    i = 0
    j = 0
    check = []
    tmp = 0 
    tmp_j = 0
    open.each_index do |i|
      if i.even?
        if open.count(open[i]) >= 2
          if open[i] == tmp
            break unless check == []
            result << (open[tmp_j]+open[tmp_j+1]).to_s
            result << (open[i]+open[i+1]).to_s
            check << tmp_j
            check << i
          end
          tmp = open[i]
          tmp_j = i
        end
      end 
    end
    return false if check == []
    if hidden[i] == hidden[i+2]
      hidden.each_index do |i|
        result << (hidden[i]+hidden[i+1]).to_s if i.even?
      end
      open.each_index do |i|
        next if check.include?(i)
        break if result.size == 5
        result << (open[i]+open[i+1]).to_s if i.even?
      end
      return result
    elsif open.count(hidden[i]) >= 1
      j = open.index(hidden[i])
    elsif open.count(hidden[i+2]) >= 1 
      j = open.index(hidden[i+2])
    else
      return false
    end
    hidden.each_index do |i|
      result << (hidden[i]+hidden[i+1]).to_s if i.even?
    end
    result << (open[j]+open[j+1]).to_s 
  end

  def one_pair(hidden, open)
    result = []
    i = 0
    j = 0
    hidden.each_index do |i|
      result << (hidden[i]+hidden[i+1]).to_s if i.even?
    end
    if hidden[i] == hidden[i+2]
      open.each_index do |i|
        break if i == 6
        result << (open[i]+open[i+1]).to_s if i.even?
      end
    elsif open.count(hidden[i]) >= 1
      j = open.index(hidden[i])
    elsif open.count(hidden[i+2]) >= 1 
      j = open.index(hidden[i+2])
    else
      return false
    end
    return result if hidden[i] == hidden[i+2]
    result << (open[j]+open[j+1]).to_s
    open.delete_at(j)
    open.delete_at(j+1)
    open.each_index do |i|
      break if i == 4
      result << (open[i]+open[i+1]).to_s if i.even?
    end
    result
  end

  def high_hand(hidden, open)
  end
# Finds if the cards of one color 
  def one_color(hidden, open)
    i = 1
    result = []
    if hidden[i] != hidden[i+2]
      return false
    elsif open.count(hidden[i]) < 3
      return false
    else
      open.each_index do |j|
        if open[j] == hidden[i]
          result << open[j-1]
          result << open[j]
        end 
      end 
    end
    result
  end

# Finds sequence of cards
  def sequence(hidden, open)
    weight = { 1 => "A", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9", 
      10 => "T", 11 => "J", 12 => "Q", 13  => "K" }
    i = 0
    result = []
    inputs = 1
    differ = 0
    if weight.key(hidden[i]) > weight.key(hidden[i+2])
      small = weight.key(hidden[i+2])
      big = weight.key(hidden[i])
      differ = big - small
    elsif weight.key(hidden[i]) < weight.key(hidden[i+2])
      small = weight.key(hidden[i])
      big = weight.key(hidden[i+2])
      differ = big - small
    else
      return false
    end
    return false if differ > 4
    if differ > 1
      start = small + 1
      end1 = big - 1
      start.upto(end1) do |j|
        open.each_index do |k|
          if open[k] ==  weight[j]
            unless result.include? weight[j]
              result << open[k]
              result << open[k+1]
              inputs += 1
            end 
          end 
        end 
      end
    end
    return false unless differ == inputs  
    if result.size < 6
      steps = (6-result.size)/2
      start = big + 1
      end1 = big + steps
      start.upto(end1) do |j|
        open.each_index do |k|
          if open[k] ==  weight[j]
            unless result.include? weight[j]
              result << open[k]
              result << open[k+1]
            end 
          end 
        end 
      end
      if result.size < 6
        steps = (6-result.size)/2
        return false if small - steps < 1  
        start = small - steps
        end1 = small - 1
        start.upto(end1) do |j|
          open.each_index do |k|
            if open[k] ==  weight[j]
              unless result.include? weight[j]
                result << open[k]
                result << open[k+1]
              end 
            end  
          end 
        end
        return false if result.size < 6
      end
    end  
    result         
  end 
end
