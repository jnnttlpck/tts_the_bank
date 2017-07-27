require_relative 'the_bank_classes' #points to classes in the_bank_classes

@customers = []
@accounts = []

def welcome_screen

  puts "Welcome to our credit union"
  puts "Please enter your choice:"
  puts "-------------------------"
  puts "1. Account sign-in"
  puts "2. New customer registration:"
  puts "3. Exit ATM"

  choice = gets.chomp.to_i

  case choice
  when 1
    sign_in
  when 2
    sign_up("","")
  when 3
    "Bye now!"
    exit
  end

end


def sign_in

  puts "What's your name?"
  name = gets.chomp.upcase
  puts "What's your location?"
  location = gets.chomp.upcase

  if @customers.empty? # if we have zero customers
    puts "No customer found with that info."
    sign_up(name,location)
  end

  customer_exists = false
  @customers.each do |customer|
    if name == customer.name && location == customer.location #check if entered name & loc are both equal to class name and location
      @current_customer = customer
      customer_exists = true
    end
  end

  if customer_exists
    acct_menu
  else
    puts "No customer found with that info."
    puts "1. Try again"
    puts "2. Sign up"
    choice = gets.chomp.to_i
    case choice
    when 1
      sign_in
    when 2
      sign_up(name, location) #even though these are being passed to a different method, these don't have to be instance variables since they won't be used again
    end
  end

end


def sign_up(name, location)

  if name == "" && location == "" #if not passed w/ name and location
    puts "What's your name?"
    name = gets.chomp
    puts "What's your location?"
    location = gets.chomp
  end

  @current_customer = Customer.new(name,location) #create new customer and set it to be current_customer
  @customers.push(@current_customer) #add new cusotmer to array of customers
  puts "Registration Successful!"
  acct_menu
end


def acct_menu

  puts "Account Menu:"
  puts "---------------------------------------------------"
  puts "1. Create Account"
  puts "2. Review Account"
  puts "3. Sign Out"

  choice = gets.chomp.to_i

  case choice
  when 1
    create_account
  when 2
    review_account
  when 3
    puts "Thank you for using our credit union!"
    welcome_screen
  else
    puts "Invalid Selection"
    acct_menu
  end

end


def create_account

  puts "How much will your initial deposit be?"
  print "$"
  amount = gets.chomp.to_f
  puts "What type of account is this?"
  type = gets.chomp.upcase

  new_account = Account.new(@current_customer, type, (@accounts.length + 1), amount)
  @accounts.push(new_account)

  puts "Account successfully created!"
  acct_menu

end

def review_account

  current_account = ""
  puts "What type of account would you like to review?"
  type = gets.chomp.upcase

  account_exists = false
  @accounts.each do |account|
    if @current_customer == account.customer && type == account.account_type
      @current_account = account
      account_exists = true
    end
  end

  if account_exists
    current_account_actions
  else
    puts "No account type found"
    acct_menu
  end

end

def current_account_actions

  puts "Choose one of the following:"
  puts "----------------------------"
  puts "1. Check balance"
  puts "2. Make a deposit"
  puts "3. Make a withdrawal"
  puts "4. Back to Account Menu"
  puts "5. Sign out"

  choice = gets.chomp.to_i

  case choice
  when 1
    puts "Your current balance is $#{'%0.2f' %(@current_account.balance)}"
    acct_menu
  when 2
    @current_account.deposit
    acct_menu
  when 3
    @current_account.withdrawal
    acct_menu
  when 4
    acct_menu
  when 5
    "You've been signed out. Thanks for using us!"
    welcome_screen
  end

end

welcome_screen
