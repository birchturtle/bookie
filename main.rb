require("./book.rb")
require("./db.rb")

class Main
  def run
    a = Author.new("Kurt")
    g = Genre.new("Horror", "Skøn")
    b = Book.new("Bogens titel", false, a, g, 2)
    b2 = Book.new("Anden bogs titel", true, a, g, 1)
  end
end

puts "Hello!"
puts ""

main = Main.new
main.run
