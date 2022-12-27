require "sqlite3"
require "rspec"
require("./book.rb")

private class Db
    def initialize(filename)
    @db = SQLite3::Database.new filename
  end
end

class BookDb < Db
  def getAllBooks
  end
  def getBooksPerAuthor
  end
  def getBooksPerGenre
  end
  def getByPriority(num)
  end
  def addBook(b)
  end
end

class GenreDb < Db
  def addGenre(g)
  end
end

class AuthorDb < Db
  def initialize(filename)
    super(filename)
    rows = @db.execute <<-SQL
         CREATE TABLE IF NOT EXISTS Authors (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Name varchar(255)
                );
SQL
  end
  def addAuthor(a)
    @db.execute "INSERT INTO Authors VALUES ( ? )", a.name
  end
end

describe "author database" do
  it "creates table on init" do
    authorDb = AuthorDb.new("test.sqlite3")

    expect(authorDb.class).to eq(AuthorDb)
  end

  it "can add an author" do
    authorDb = AuthorDb.new "test.sqlite3"
    author = Author.new "Test Testesen"
    authorDb.addAuthor(author)

    
  end
end
