# frozen_string_literal: true

require './interactor'

class Main
  INTERACTOR = Interactor.new 'bookie.sqlite3'
  def initialize
    @running = true
  end

  def run
    if ARGV[0] == '-h'
      print_help
      exit 0
    elsif ARGV[0] == '-l'
      if ARGV[1] == '-c'
        INTERACTOR.list_books_by_priority
        exit 0
      end
      INTERACTOR.list_book
      exit 0
    end
    init_menu while @running
  end

  private

  def print_help
    puts 'Useful help text here :-)'
  end
  def init_menu
    puts 'Would you like to..?'
    puts <<-MENU
      L)ist
      D)elete
      A)dd or update existing
      Q)uit
    MENU
    action = gets.strip
    case action
    when 'l'
      entity_menu 'list'
    when 'd'
      entity_menu 'delete'
    when 'a'
      entity_menu 'add'
    when 'q'
      @running = false
    else
      print_help
    end
  end


  def entity_menu(action)
    puts 'What..?'
    puts <<-MENU
      B)ook
      A)uthor
      G)enre
    MENU
    entity = gets.strip
    case entity
    when 'b'
      INTERACTOR.send("#{action}_book".to_sym)
    when 'a'
      INTERACTOR.send("#{action}_author".to_sym)
    when 'g'
      INTERACTOR.send("#{action}_genre".to_sym)
    else
      print_help
      exit 0
    end
  end
end

puts 'Hello!'
puts ''

main = Main.new
main.run
