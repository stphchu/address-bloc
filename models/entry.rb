class Entry
    # These must be accessors since we mutate them
    attr_accessor :name, :phone_number, :email
    
   def initialize(name, phone_number, email)
      @name = name
      @phone_number = phone_number
      @email = email
   end
   
    # #7
   def to_s
    "Name: #{name}\nPhone Number: #{phone_number}\nEmail: #{email}"
   end
end