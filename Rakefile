$LOAD_PATH.unshift File.expand_path( File.dirname(__FILE__) )

require 'rake'
require 'sinatra/activerecord/rake'
require 'app'

namespace :muzak do
  desc 'Populate database with songs.'
  task :populate_songs do
    en = EchoNest.new(Muzak.config.echonest_api_key)
    
    styles = en.styles
    moods  = en.moods
    
    imported = 0
    styles.each do |style|
      moods.each do |mood|
        
        puts "#{style} : #{mood}"
        
        songs = en.songs({
          :results => 100,
          :style => style,
          :mood  => mood,
          :bucket => 'id:spotify-WW',
          :bucket => 'song_hotttnesss',
          :bucket => 'artist_familiarity',
          :bucket => 'artist_hotttnesss'
        })
        
        songs.each do |song|
          puts "#{song.title}"
          
          if song = Muzak::Song.where(:echonest_id).first
          
          else
            if song = Muzak::Song.from_echonest(song)
              imported += 1 
              
              Genre.create({
                :style => style,
                :mood => mood,
                :song_id => song.id
              })
            end              
          end  
        end  
      end  
    end
    
    puts "Imported #{imported} songs."  
  end  
end  
