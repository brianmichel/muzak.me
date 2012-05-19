module Muzak
  class Song < ActiveRecord::Base
    belongs_to :genre
    
    validate :title,
     :presence => true,
     :uniqueness => true, :scope => :artist_id
    
    validate :spotify_id,
      :uniqueness => true
     
     
    def self.from_echonest(echonest_song)
      song = new({
        :echonest_id => echonest_song.id,
        :artist_id => echonest_song.artist_id,
        :artist_name => echonest_song.artist_name,
        :title => echonest_song.title,
        :artist_familiarity => echonest_song.artist_familiarity, 
        :hotness => echonest_song.song_hotttnesss,
        :artist_hotness => echonest_song.artist_hotttness,
        :spotify_id => echonest_song.spotify_id
      })
      
      if song.save
        song
      else
        nil
      end              
    end 
  end  
end
  