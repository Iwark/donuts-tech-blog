# == Schema Information
#
# Table name: article_tags
#
#  id         :integer          not null, primary key
#  article_id :integer          not null
#  tag_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_article_tags_on_article_id  (article_id)
#  index_article_tags_on_tag_id      (tag_id)
#

class ArticleTag < ActiveRecord::Base
  belongs_to :article
  belongs_to :tag
  counter_culture :tag, column_name: Proc.new { |model| model.article.public? ? 'articles_count' : nil }

end
