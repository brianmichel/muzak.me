class Genres < ActiveRecord::Migration
  def self.up
    create_table :genres do |t|
      t.string :mood
      t.string :style
      t.integer :song_id
    end  
    
    add_index :genres, :style
    add_index :genres, [:mood, :style]
  end

  def self.down
    drop_table :genres
  end
end
