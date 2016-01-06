class CreateArticleImages < ActiveRecord::Migration
  def change
    create_table :article_images do |t|
      t.references :user, index: true
      t.references :article, index: true
      t.string :image

      t.timestamps null: false
    end
    add_foreign_key :article_images, :users
    add_foreign_key :article_images, :articles
  end
end
