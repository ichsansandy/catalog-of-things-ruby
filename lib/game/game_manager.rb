require 'json'

module GamesManager
  def store_games(all_games)
    return if all_games.empty?

    file = './Data/games.json'
    File.new('./Data/games.json', 'w+') unless File.exist?(file)

    data = []

    all_games.each do |game|
      data << { id: game.id, publish_date: game.publish_date, archived: game.archived,
                multiplayer: game.multiplayer, last_played_at: game.last_played_at.to_s , genre_id: game.genre.id, 
                author_id: game.author.id, label_id: game.label.id }
    end
    File.write(file, JSON.generate(data))
  end

  def fetch_games(all_author, all_label, all_genre)
    file = './Data/games.json'
    data = []

    return data unless File.exist?(file) && !File.empty?(file)

    JSON.parse(File.read(file)).each do |game|
      new_game = Game.new(game['multiplayer'], game['last_played_at'],
                          game['publish_date'], game['id'], archived: game['archived'])

      new_game.author = all_author.find { |author| author.id == game["author_id"]  }
    #   new_game.label = all_label.find { |label| label.id == game["label_id"]  }
    #   new_game.genre = all_genre.find { |genre| genre.id == game["genre_id"]  }

      data << new_game
    end
    data
  end
end
