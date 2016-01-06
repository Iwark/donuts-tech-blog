class AddSeriesIdToArticles < ActiveRecord::Migration
  def change
    add_reference :articles, :series, index: true
    add_foreign_key :articles, :series
  end
end
