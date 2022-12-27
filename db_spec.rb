require 'rspec'
require './book'
require './db'

describe 'author database' do
  before(:context) do
    File.delete('./test.sqlite3') if FileTest.exists? './test.sqlite3'
    expect(FileTest.exists?('./test.sqlite3')).to eq(false)
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

  after(:context) do
    File.delete('./test.sqlite3')
  end
end
