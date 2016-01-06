class CreateArticleTags < ActiveRecord::Migration
  def change
    create_table :article_tags do |t|
      t.references :article, index: true, null: false
      t.references :tag, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :article_tags, :articles
    add_foreign_key :article_tags, :tags
  end
end
