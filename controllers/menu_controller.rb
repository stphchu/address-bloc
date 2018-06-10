require_relative '../models/address_book'
 
class MenuController
   attr_reader :address_book
 
   def initialize
     @address_book = AddressBook.new
   end
 
   def main_menu
     puts "Main Menu - #{address_book.entries.count} entries"
     puts "1 - View all entries"
     puts "2 - Create an entry"
     puts "3 - Search for an entry"
     puts "4 - Import entries from a CSV"
     puts "5 - View Entry Number n"
     puts "6 - Nuke all entries"
     puts "7 - Exit"
     print "Enter your selection: "
 
     selection = gets.to_i
     
     # #7
     case selection
      when 1
         system "clear"
         view_all_entries
         main_menu
      when 2
         system "clear"
         create_entry
         main_menu
      when 3
         system "clear"
         search_entries
         main_menu
      when 4
         system "clear"
         read_csv
         main_menu
      when 5
         system "clear"
         search_entry_number
         main_menu
      when 6
         system "clear"
         nuke_entries
         main_menu
      when 7
         puts "Good-bye!"
         # #8
         exit(0)
      # #9
      else
         system "clear"
         puts "Sorry, that is not a valid input"
         main_menu
     end
   end
 
   # #10
   def view_all_entries
      # #14
      address_book.entries.each do |entry|
         system "clear"
         puts entry.to_s
         # #15
         entry_submenu(entry)
      end
 
      system "clear"
      puts "End of entries"
   end
 
   def create_entry
      # #11
      system "clear"
      puts "New AddressBloc Entry"
      # #12
      print "Name: "
      name = gets.chomp
      print "Phone number: "
      phone = gets.chomp
      print "Email: "
      email = gets.chomp
      
   # #13
     address_book.add_entry(name, phone, email)
 
     system "clear"
     puts "New entry created"
   end
 
   def search_entries
      # #9
      print "Search by name: "
      name = gets.chomp
      # #10
      match = address_book.binary_search(name)
      system "clear"
      # #11
      if match
         puts match.to_s
         search_submenu(match)
      else
         puts "No match found for #{name}"
      end
   end
 
   def read_csv
      # #1
      print "Enter CSV file to import: "
      file_name = gets.chomp
 
      # #2
      if file_name.empty?
         system "clear"
         puts "No CSV file read"
         main_menu
      end
 
      # #3
      begin
         entry_count = address_book.import_from_csv(file_name).count
         system "clear"
         puts "#{entry_count} new entries added from #{file_name}"
      rescue
         puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
         read_csv
      end
   end
   
   def search_entry_number
      print "Enter entry number to look up: "
      entry_number = gets.chomp.to_i
         if entry_number.to_i <= address_book.entries.count
            print "\n#{address_book.entries[entry_number]}\n\n"
         else
            puts "Not a valid entry number\n\n"
            search_entry_number
         end
   end
   
   def entry_submenu(entry)
      # #16
      puts "n - next entry"
      puts "d - delete entry"
      puts "e - edit this entry"
      puts "m - return to main menu"
 
      # #17
      selection = gets.chomp
 
      case selection
      # #18
         when "n"
      # #19
         when "d"
            delete_entry(entry)
         when "e"
            edit_entry(entry)
            entry_submenu(entry)
      # #20
         when "m"
            system "clear"
            main_menu
         else
            system "clear"
            puts "#{selection} is not a valid input"
            entry_submenu(entry)
      end
   end
   
   def delete_entry(entry)
      address_book.entries.delete(entry)
      puts "#{entry.name} has been deleted"
   end

   def edit_entry(entry)
     # #4
     print "Updated name: "
     name = gets.chomp
     print "Updated phone number: "
     phone_number = gets.chomp
     print "Updated email: "
     email = gets.chomp
     # #5
     entry.name = name if !name.empty?
     entry.phone_number = phone_number if !phone_number.empty?
     entry.email = email if !email.empty?
     system "clear"
     # #6
     puts "Updated entry:"
     puts entry
   end

   def search_submenu(entry)
      # #12
      puts "\nd - delete entry"
      puts "e - edit this entry"
      puts "m - return to main menu"
      # #13
      selection = gets.chomp
 
      # #14
      case selection
         when "d"
            system "clear"
            delete_entry(entry)
            main_menu
         when "e"
            edit_entry(entry)
            system "clear"
            main_menu
         when "m"
            system "clear"
            main_menu
         else
            system "clear"
            puts "#{selection} is not a valid input"
            puts entry.to_s
            search_submenu(entry)
      end
   end
   
   def nuke_entries
      print "Nuke entries? **This will erase all current entries** (Y/N): "
      confirmation = gets.chomp
      
      case confirmation.downcase
         when "y"
            address_book.nuke
            system "clear"
            puts "\n** All entries have been erased **\n\n"
            main_menu
            
         when "n"
            system "clear"
            main_menu
         else
            puts "Not a valid response\n\n"
            nuke_entries
      end
   end
   
end