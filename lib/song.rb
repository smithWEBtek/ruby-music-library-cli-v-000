class Song
 
	attr_accessor :name
	attr_reader :genre
	@@all = []

  def initialize(name, artist = nil, genre = nil)
		@name = name
		if artist != nil
      self.artist= artist
		end
		if genre != nil 
			self.genre= genre
		end
		save
  end
	
	def self.all
		@@all
	end
	
	def self.destroy_all
		@@all = []
	end
	
	def save
		@@all << self
	end
	
	def self.create(song)
		newSong = self.new(song)
	end

	def artist
		@artist
	end

	def artist=(artist)
		@artist = artist 
		artist.add_song(self)
	end

	def genre=(genre)
		@genre = genre
		genre.add_song(self)
	end

	def self.find_by_name(name)
		@@all.each do |song|
			if song.name == name
				return song
			end
		end
	end

	def self.find_or_create_by_name(name)
		song = Song.find_by_name(name)
		if @@all.include?(song)
			song
		else
			Song.create(name)
		end
	end

  def self.new_from_filename(filename)
    parts = filename.split(" - ")
		artist_name = parts[0]
		song_name = parts[1]
		genre_name = parts[2].gsub(".mp3", "")
 
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    new(song_name, artist, genre)
  end

	def self.create_from_filename(filename)
		Song.new_from_filename(filename) 
  end

end