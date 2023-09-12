require_relative 'lib/music/music_album'
require_relative 'lib/item/genre'
require_relative 'lib/music/music_list'
require_relative 'lib/list_book'
require_relative 'lib/game'
require_relative 'lib/game_save'

class App
  def initialize
    @music = MusicList.new
    @list_book = ListBook.new
    @game = GameList.new
  end

  def select_option(option)
    case option
    when '1'
      @list_book.list_all_books
    when '2'
      @music.list_all_music_albums
    when '3'
      @game.list_all_games
    when '4'
      @music.list_all_genre
    when '5'
      @list_book.list_all_labels
    when '6'
      @game.list_all_authors
    end
  end

  def add_items(option)
    case option
    when '7'
      @list_book.add_book
    when '8'
      @music.add_music_album
    when '9'
      @game.add_game
    end
  end
end