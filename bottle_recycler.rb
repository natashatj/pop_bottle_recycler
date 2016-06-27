class BottleRecycler
  attr_accessor :purchased_bottles, :bottle_caps, :empty_bottles, :extra_empty_bottles, :extra_bottle_caps, :bottles_from_empty_bottles, :bottles_from_bottle_caps, :total_bottles, :money, :change

  def initialize
    @purchased_bottles = 0
    @bottle_caps = 0
    @empty_bottles = 0
    @extra_bottle_caps = 0
    @extra_empty_bottles = 0
    @bottles_from_empty_bottles = 0
    @bottles_from_bottle_caps = 0
    @total_bottles = 0
    @money =0
    @change = 0
  end

  def recycle
    prompt_user_for_input
    purchase_bottles_with_money
    recycle_first_purchase
    receive_bottles_from_recycling
    update_total_bottles
    show_result
  end


  def receive_bottles_from_recycling
    until not_enough_bottle_caps
      receive_bottles_from_bottle_caps
    end
    until not_enough_empty_bottles
      receive_bottles_from_empty_bottles
    end
  end

  def receive_bottles_from_bottle_caps
    extra_caps = @bottle_caps % 4
    @extra_bottle_caps += extra_caps
    redeemable_caps = @bottle_caps - extra_caps
    @bottle_caps -= redeemable_caps
    @bottles_from_bottle_caps += redeemable_caps / 4
  end

  def receive_bottles_from_empty_bottles
    extra_empty_bottles = @empty_bottles % 2
    @extra_empty_bottles += extra_empty_bottles
    redeemable_empty_bottles = @empty_bottles - extra_empty_bottles
    @empty_bottles -= redeemable_empty_bottles
    @bottles_from_empty_bottles += redeemable_empty_bottles / 2
  end

  def update_total_bottles
    @total_bottles = (@bottles_from_bottle_caps + @bottles_from_empty_bottles + @purchased_bottles)
  end

  def show_result
    puts "Payment of $#{@money}"
    puts "Change of $#{@change}"
    puts "Number of purchased bottles: #{@purchased_bottles}"
    puts "Number of leftover caps: #{@extra_bottle_caps}"
    puts "Number of leftover bottles: #{@extra_empty_bottles}"
    puts "Number of bottles from caps: #{@bottles_from_bottle_caps}"
    puts "Number of bottles from empty bottles: #{@bottles_from_empty_bottles}"
    puts "Total bottles recieved: #{@total_bottles}"
    puts 'You are only ' + "#{4-@extra_bottle_caps} #{4-@extra_bottle_caps == 1 ? 'bottle cap' : 'bottle caps'}" + ' OR ' + "#{2-@extra_empty_bottles} #{2-@extra_empty_bottles == 1 ? 'empty bottle' : 'empty bottles'}" + ' away from a free bottle of pop!'
  end

  def recycle_first_purchase
    @bottle_caps += @purchased_bottles
    @empty_bottles += @purchased_bottles
    @extra_bottle_caps = @purchased_bottles if @purchased_bottles < 4
    @extra_empty_bottles = @purchased_bottles if @purchased_bottles < 2
  end

  def purchase_bottles_with_money
    @purchased_bottles = @money / 2
  end

  def prompt_user_for_input
    print 'How much do you want to pay for our delicious bottles of pop? '
    amount = gets.chomp.to_i
    amount >= 2 ? accept_exact_change(amount) : reprompt_user_for_input
  end

  def reprompt_user_for_input
    print 'Must be a number more than 2$ to purchase a bottle of pop: '
    amount = gets.chomp.to_i
    amount >= 2 ? accept_exact_change(amount) : reprompt_user_for_input
  end

  def accept_exact_change(amount)
    @money = (amount % 2 == 0 ? amount : amount - 1)
    @change = 1 unless amount % 2 == 0
  end

  def not_enough_bottle_caps
    @bottle_caps < 4
  end

  def not_enough_empty_bottles
    @empty_bottles < 2
  end
end