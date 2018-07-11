require_relative('../db/sql_runner')

class Album

  attr_accessor :artist_id, :genre, :title
  attr_reader :id

  def initialize(options)
    @artist_id = options['artist_id'].to_i
    @genre = options['genre']
    @title = options['title']
    @id = options['id'].to_i if options['id']
  end


  def save()
    sql = "INSERT INTO albums(artist_id, genre, title) VALUES ($1, $2, $3) RETURNING id"
    values = [@artists_id, @genre, @title]
    artist = SqlRunner.run(sql,values)
    @id = artist[0]["id"].to_i
  end

def update(
  sql = 'UPDATE albums SET (artist_id, genre, title) = ($1,$2,$3) WHERE id = $4'
)
values = [@artist_id, @genre, @title, @id]
SqlRunner.run(sql, values)
end

def delete_by_id
  sql = "DELETE FROM albums where id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
  sql = "DELETE FROM albums"
  SqlRunner.run(sql)
end

def artist
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [ @artist_id ]
    artist = SqlRunner.run(sql,values)
    artist_hash = artist.first
    artist = Artist.new(artist_hash)
    return artist
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    albums = SqlRunner.run(sql,values)
    album = Artist.new(albums.first)
    return album
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map { |albums_hash| Album.new(albums_hash) }
  end


end
