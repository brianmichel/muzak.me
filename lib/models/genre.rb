class Genre < ActiveRecord::Base
  has_many :songs
  
  def self.songs(args = {})
    genres = Genre.all  
    genres = genres.where(:mood => args[:mood]) if args[:mood]
    genres = genres.where(:style => args[:style]) if args[:style]      
    
    genres.songs
  end  
end
  