require_relative 'contact'
require 'sinatra'

class CRM

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def name_of_app
    "This application is called " + @name
  end

  # given to us in the exercise - basically always has the main menu running
  def main_menu
    loop do # repeat indefinitely - inifinite loop
      print_main_menu # calls print_main_menu method
      user_selected = gets.to_i # stores user input into a local variable
      call_option(user_selected) # passes local variable to call_option mehtod below
    end
  end

  def print_main_menu
    puts '[1] Add new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all contacts'
    puts '[5] Search by attributes'
    puts '[6] Exit'
    puts 'Enter a number: '
  end
  # We have two methods: print_main_menu prints out the menu and main_menu calls print_main_menu and then stores the user input (a number) into a variable called user_selected. That variable then gets passed as an argument into call_option

  # ------------------------------------------------------------------------

  # What do you think call_option should do? Remember, user_selected is going to be a number. What we want to do in this method is call other methods based on the number.
  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5 then search_by_attribute
    when 6 then exit(0)# can also do else exit as the last condition, up to programmer
    end
  end

  # this is where we get the values for the contact class initializer we then pass in the values stored in the local variables into the contact.create function
  def add_new_contact
    print "Please enter First Name: "
    first_name = gets.chomp.to_s

    print "Please enter Last Name: "
    last_name = gets.chomp.to_s

    print "Please enter your Email address: "
    email = gets.chomp.to_s

    print "Please enter a Note: "
    note = gets.chomp.to_s

    Contact.create(
      first_name: first_name,
      last_name:  last_name,
      email:      email,
      note:       note
    )
  end

  def modify_existing_contact
    # first we need to get the inputs from the user so we know what to pass into the find class method.
    print "Please enter the ID# of the contact you want to update: \n"
    id = gets.chomp.to_i

    # once we know the ID value, we then need t know which attribute we want to pass into update method -- see method in contact.rb
    print "What aspect(field) of the contact would you like to change?: \n"
    attribute = gets.chomp

    # now that we have the attribute and id saved in variables, we need the final piece which will be the new value for the attribute, we are also passing this variable to the update method
    print "We will change #{attribute}. Please enter the new value: \n"
    value = gets.chomp

    # now that we have all the info stored in variables, we can start using the mehtods
    contact = Contact.find(id)
    contact.update(attribute => value) # pulling method from contact file
    # using a hash rocket as acctive record requires hash as the argument

  end

  def delete_contact
    print "Enter the ID of the contact you wish to delete: \n"
    delete_id = gets.chomp.to_i
    Contact.delete(delete_id)

  end

  def display_all_contacts
    print "Below is a list of all the contacts in storage at the moment: \n"
    Contact.all.each {|contact| puts contact.inspect}
    puts
  end

  def search_by_attribute
    print "Please enter the field/attribute you would like to search? \n"
    print "Choose from: first_name, last_name, email, note: \n"
    attribute = gets.chomp

    print "Now we need the value of the attribute/field: \n"
    value = gets.chomp

    puts Contact.find_by(attribute => value).inspect # key => paid always
    # if i use (attribute: name) it would not work, it goes to find attribute column name instead with the value name
  end
end

at_exit do
  ActiveRecord::Base.connection.close
end

# contact1 = Contact.create('Betty', 'Maker', 'bettymakes@gmail.com', 'Loves Pokemon')
# contact2 = Contact.create('Alfonso', 'Rubel', 'alnfonso@mail.com', 'cooks a lot')
# contact3 = Contact.create('Mauricio', 'Nadal', 'nadal@mail.com', 'plays soccer')
# contact4 = Contact.create('Meliza', 'Pineda', 'meliza@mail.com', 'cleans a lot')
#
a_crm_app = CRM.new("This is my first CRM Assigment")
a_crm_app.main_menu
a_crm_app.print_main_menu
