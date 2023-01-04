require("./book.rb")
require("./db.rb")

# frozen_string_literal: true

class Interactor
  def add_book
    puts "Adding book!"
  end
  def delete_book
    puts "Deleting book!"
  end
  def list_book
    puts "Listing book(s)!"
  end
  def add_author
    puts "Adding author!"
  end
  def delete_author
    puts "Deleting author!"
  end
  def list_author
    puts "Listing author(s)!"
  end
  def add_genre
    puts "Adding genre!"
  end
  def delete_genre
    puts "Deleting genre!"
  end
  def list_genre
    puts "Listing genre(s)!"
  end
end
