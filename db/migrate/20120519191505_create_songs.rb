class CreateSongs < ActiveRecord::Migration
  def self.up
    create_table :songs do |t|
      t.string :title, :null => false
      t.string :artist_name
      t.string :artist_id
      t.string :spotify_id
      t.decimal :hotness
      t.decimal :artist_hotness
      t.decimal :artist_familiarity
      
      t.timestamps
    end  
  end

  def self.down
    drop_table :songs
  end
end
