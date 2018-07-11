require_relative('../db/sql_runner')
require("byebug")

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def albums
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [ @id ]
    albums = SqlRunner.run(sql, values)
    return albums.map { |albums_hash| Album.new(albums_hash) }
  end

  def save
    sql = "INSERT INTO artists(name) VALUES ($1) RETURNING id"
    values = [@name]
    artists = SqlRunner.run(sql,values)
    @id = artists[0]["id"].to_i
  end


  def update
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql,values)
  end

  def delete_by_name
    sql = "DELETE FROM artists where name = $1"
    values = [@name]
    SqlRunner.run(sql, values)
  end

  def delete_by_id(id)
    sql = "DELETE FROM artists where id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    artists = SqlRunner.run(sql,values)
    artist = Artist.new(artists.first)
    return artist
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map { |artists_hash| Artist.new(artists_hash) }
  end


end
