class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :user, index: true
      t.string :title
      t.text :body

      t.timestamps null: false
    end
    add_foreign_key :articles, :users
  end
end
