require './interactor.rb'
class Main
  INTERACTOR = Interactor.new "bookie.sqlite3"
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
    puts "Would you like to..?"
    puts <<-MENU
      L)ist
      D)elete
      A)dd
    MENU
    action = gets
    case action.tr("\n", "")
             when "l"
               entity_menu "list"
             when "d"
               entity_menu "delete"
             when "a"
               entity_menu "add"
             else
               print_help
               exit 0
             end
  end
  def entity_menu(action)
    puts "What..?"
    puts <<-MENU
      B)ook
      A)uthor
      G)enre
    MENU
    entity = gets
    case entity.tr("\n", "")
             when "b"
               INTERACTOR.send((action + "_" + "book").to_sym)
             when "a"
               INTERACTOR.send((action + "_" + "author").to_sym)
             when "g"
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
