class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet_id
      t.string :user_name
      t.string :text
      t.string :latitude
      t.string :longitude
      t.string :sentiment
      t.string :created_at

      t.timestamps
    end
  end
end
