# == Schema Information
#
# Table name: tags
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  parent_id      :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0), not null
#  articles_count :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_tags_on_lft        (lft)
#  index_tags_on_parent_id  (parent_id)
#  index_tags_on_rgt        (rgt)
#

class Tag < ActiveRecord::Base
  acts_as_nested_set counter_cache: :children_count

  has_many :article_tags
  has_many :articles, through: :article_tags

  def deletable?(user, article_id)
    article = Article.find(article_id)
    user.administrator? || article.user_id == user.id
  end

end
