class GenreSongs < ActiveRecord::Migration
  def self.up
    create_table :genre_songs do
      t.integer :genre_id
      t.integer :song_id
      t.timestamps
    end  
  end

  def self.down
  end
end
