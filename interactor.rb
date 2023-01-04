require("./book.rb")
require("./db.rb")

# frozen_string_literal: true

class Interactor
  def initialize(databaseFile)
    @authorDb = AuthorDb.new(databaseFile)
    @bookDb = BookDb.new(databaseFile)
    @genreDb = GenreDb.new(databaseFile)
  end
  def add_book
    puts "Title?"
    title = gets.tr("\n", "")

    puts "Author? Note: Must match existing name in author database"
    author_name = gets.tr("\n", "")
    author = @authorDb.get_author_by_name(author_name)
    if author.nil?
      puts "Error: #{author_name} does not exist. Please add it first."
      exit 0
    end

    puts "Genre? Note: Must match existing name in genre database"
    genre_name = gets.tr("\n", "")
    genre = @genreDb.get_genre_by_name(genre_name)
    if genre.nil?
      puts "Error: #{genre_name} does not exist. Please add it first."
      exit 0
    end

    puts "Read? ('y' or 'n')"
    read = gets.tr("\n", "") == 'y' ? true : false
    puts "Priority? (0 highest, ...n lowest)"
    priority = gets.tr("\n", "").to_i

    @bookDb.add_book(Book.new(nil, title, read, author.id, genre.id, priority))
    book = @bookDb.get_by_name(title)
    if book.nil?
      puts "Failed to add #{title}"
      exit 1
    end
    puts "Book added successfully!"
    summarize_book(book, author, genre)
  end
  def delete_book
    puts "Deleting book!"
  end
  def list_book
    puts "Listing book(s)!"
  end
  def add_author
    puts "Name?"
    name = gets.tr("\n", "")
    @authorDb.add_author(Author.new(nil, name))
    author = @authorDb.get_author_by_name(name)
    if author.nil?
      puts "Failed to add author"
    else
      puts "Added #{author.name} to the database succesfully."
    end
  end
  def delete_author
    puts "Deleting author!"
  end
  def list_author
    puts "Listing author(s)!"
  end
  def add_genre
    puts "Name?"
    name = gets.tr("\n", "")
    puts "Type? ('f' for fiction, 'nf' for non-fiction)"
    type = case gets.tr("\n", "")
           when 'f'
             "Fiction"
           when 'nf'
             "Non-Fiction"
           end
    @genreDb.add_genre(Genre.new(nil, name, type))
    genre = @genreDb.get_genre_by_name(name)
    if genre.nil?
      puts "Failed to add #{name} to genre database."
    else
      puts "Added #{genre.name} (#{genre.type}) to database successfully."
    end
  end
  def delete_genre
    puts "Deleting genre!"
  end
  def list_genre
    puts "Listing genre(s)!"
  end
  private
  def summarize_book(book, author, genre)
    puts "Title: #{book.title} (by #{author.name})"
    puts "#{'not ' unless book.read?}read, considered to be #{genre.name} (#{genre.type})"
    puts "priority: #{book.priority}"
    puts ''
  end
end
