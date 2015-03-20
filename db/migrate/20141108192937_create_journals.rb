class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string :title
      t.string :body
      t.string :font
      t.string :color

      t.references :user
      t.timestamps
    end
  end
end
