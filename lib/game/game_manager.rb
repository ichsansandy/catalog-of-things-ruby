require 'json'

module GameManager
  def store_games(all_games)
    return if all_games.empty?

    file = './Data/games.json'
    File.new('./Data/games.json', 'w+') unless File.exist?(file)

    data = []

    all_games.each do |game|
      data << { id: game.id, publish_date: game.publish_date, archived: game.archived,
                multiplayer: game.multiplayer, last_played_at: game.last_played_at.to_s,
                genre_id: game.genre.nil? ? nil : game.genre.id,
                author_id: game.author.nil? ? nil : game.author.id,
                label_id: game.label.nil? ? nil : game.label.id }
    end
    File.write(file, JSON.generate(data))
  end

  def fetch_games(_all_author)
    file = './Data/games.json'
    data = []

    return data unless File.exist?(file) && !File.empty?(file)

    JSON.parse(File.read(file)).each do |game|
      new_game = Game.new(game['multiplayer'], game['last_played_at'],
                          game['publish_date'], game['id'], archived: game['archived'])

      # new_game.author = all_author.find { |author| author.id == game["author_id"]  }
      # new_game.label = all_label.find { |label| label.id == game["label_id"]  }
      # new_game.genre = all_genre.find { |genre| genre.id == game["genre_id"]  }

      data << new_game
    end
    data
  end

  def add_game
    puts 'Add a new game'
    multiplayer_input = get_user_input('Is It Multiplayer ( true or false ):')
    multiplayer = (multiplayer_input.downcase == 'true')
    last_played_at = get_user_input('Last played at ( YYYY-MM-DD ):')
    publish_date = get_user_input('Official release at ( YYYY-MM-DD ):')
    new_game = Game.new(multiplayer, last_played_at, publish_date)
    puts 'Game created'
    new_game
  end

  def list_all_game
    puts '-' * 50
    if @games.empty?
      puts 'No games yet!'
    else
      puts 'The Game List: '
      @games.each_with_index do |game, index|
        puts "#{index + 1} - [Game] ID: #{game.id} - Publish date: #{game.publish_date} - " \
             "Last played date: #{game.last_played_at} - Multiplayer: #{game.multiplayer} - Archived: #{game.archived}"
      end
    end
    puts '-' * 50
  end
end
