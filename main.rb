require './interactor.rb'
class Main
  INTERACTOR = Interactor.new
  def run
    if ARGV[0] == '-h' then
      print_help
      exit 0
    end
    init_menu
  end

  private
  def print_help
    puts "Useful help text here :-)"
  end
  def init_menu
    puts "Do?"
    puts <<-MENU
      1) List
      2) Delete
      3) Add
    MENU
    action = gets
    case action.tr("\n", "")
             when "1"
               entity_menu "list"
             when "2"
               entity_menu "delete"
             when "3"
               entity_menu "add"
             else
               print_help
               exit 0
             end
  end
  def entity_menu(action)
    puts "Do?"
    puts <<-MENU
      1) Book
      2) Author
      3) Genre
    MENU
    entity = gets
    case entity.tr("\n", "")
             when "1"
               INTERACTOR.send((action + "_" + "book").to_sym)
             when "2"
               INTERACTOR.send((action + "_" + "author").to_sym)
             when "3"
               INTERACTOR.send((action + "_" + "genre").to_sym)
             else
               print_help
               exit 0
             end
  end
end

puts "Hello!"
puts ""

main = Main.new
main.run
