class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet_id
      t.string :user_name
      t.string :text
      t.float :latitude
      t.float :longitude
      t.float :sentiment
      t.string :location
      t.string :created_at

      t.timestamps
    end
  end
end
