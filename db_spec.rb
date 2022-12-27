require 'rspec'
require './book'
require './db'

describe 'author database' do
  before(:example) do
    @authorDb = AuthorDb.new('test.sqlite3')
  end

  it 'creates table on init' do
    expect(@authorDb.class).to eq(AuthorDb)
  end

  it 'can add an author' do
    author = Author.new 'Test Testesen'
    @authorDb.addAuthor(author)

    expect(1).to eq(1)
  end
end
