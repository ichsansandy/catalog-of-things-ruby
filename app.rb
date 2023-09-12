require_relative 'lib/music/music_album'
require_relative 'lib/item/genre'
require_relative 'lib/music/music_list'

require_relative 'lib/author/author'
require_relative 'lib/author/author_manager'
require_relative 'lib/game/game'
require_relative 'lib/game/game_manager'

require_relative 'lib/book/book'
require_relative 'lib/book/books_manager'
require_relative 'lib/label/label'
require_relative 'lib/label/labels_manager'


class App
  include GameManager
  include AuthorManager
  
  def initialize
    
    @music = MusicList.new
    @authors = fetch_authors
    @games = fetch_games(@authors)
  end

  def select_option(option)
    case option
    when '1'
      puts "list all books"
    when '2'
      @music.list_all_music_albums
    when '3'
      list_all_game
    when '4'
      @music.list_all_genre
    when '5'
      puts "list all labels"
    when '6'
      puts "list all games"
    end
  end

  def add_items(option)
    case option
    when '7'
      @list_book.add_book
    when '8'
      @music.add_music_album
    when '9'
      new_game = add_game
      add_author?(new_game)
      @games << new_game
      store_games(@games)
    end
  end

  
end
