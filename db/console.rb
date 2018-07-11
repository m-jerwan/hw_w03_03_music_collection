require("pry")
require_relative("../models/album")
require_relative("../models/artist")
require("byebug")

# Album.delete_all
# Artist.delete_all

#=================================

#----- Create and Save Artists

artist_01 = Artist.new ({
  'name' => 'Deadmau5'
  })
artist_02 = Artist.new({
  'name' => 'Bo'
  })

artist_01.save
artist_02.save

#---- Create and Save Albums
album_01 = Album.new ({
'artist_id' => artist_01.id, #connection is unclear
'genre' => 'house',
'title' => 'Random Album Title'
})

album_01.save


#----- List All Artists/Albums
p Artist.all
#----- List All Artists/Albums
p Album.all

#----- Edit Artists/Albums
artist_02.name = 'Bonobo'
artist_02.update

#----- Edit Artists/Albums
album_01.genre = 'progressive house'
album_01.update

#----- List all the albums they have by an artist
artist_01.albums

#----- Show the artist any album belongs to
album_01.artist

#----- Delete Artists/Albums
# artist_02.delete_by_id(1)
# artist_02.delete_by_name

#----- Find Artists/Albums by their ID
Artist.find(2)

#----- Find Artists/Albums by their ID
Album.find(1)
