class AddApprovedAtToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :approved_at, :datetime
    add_index :articles,  :approved_at
  end
end
