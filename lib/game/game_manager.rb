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
                genre_name: game.genre.nil? ? nil : game.genre.name,
                author_id: game.author.nil? ? nil : game.author.id,
                label_title: game.label.nil? ? nil : game.label }
    end
    File.write(file, JSON.generate(data))
  end

  def fetch_games
    file = './Data/games.json'
    data = []

    return data unless File.exist?(file) && !File.empty?(file)

    JSON.parse(File.read(file)).each do |game|
      new_game = Game.new(game['multiplayer'], game['last_played_at'],
                          game['publish_date'], game['id'], archived: game['archived'])

      data << new_game
    end
    data
  end

  def add_game
    puts 'Add a new game'
    multiplayer_input = get_user_input('Is It Multiplayer ( true or false )')
    multiplayer = (multiplayer_input.downcase == 'true')
    last_played_at = get_user_input('Last played at ( YYYY-MM-DD )')
    publish_date = get_user_input('Official release at ( YYYY-MM-DD )')
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

  def add_genre?(item)
    print "Want to tag #{item.class.name} to an Genre (yes/no) "
    input = gets.chomp.downcase
    add_genre_to_item(item) if input == 'yes'
  end

  def add_genre_to_item(item)
    puts "Tag genre to #{item.class.name}"
    print 'Create New genre (1) or Choose Existing (2) (Write 1 or 2) '
    input = gets.chomp
    if input == '1'
      new_genre = create_new_genre
      new_genre.add_item(item)
      puts "Genre added to #{item.class.name} successfully"
    elsif input == '2'
      @music.list_all_genre
      if @music.genres.length.positive?
        print 'Select genre index (not id) '
        index = gets.chomp.to_i - 1
        selected_genre = @music.genres[index]
        selected_genre.add_item(item)
        puts "Genre added to #{item.class.name} successfully"
      end
    end
  end

  def create_new_genre
    name = get_user_input('Write the genre you want to create')
    new_genre = Genre.new(name)
    @music.genres << new_genre
    @music.save_genre
    new_genre
  end
end
