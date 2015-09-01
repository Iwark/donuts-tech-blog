# == Schema Information
#
# Table name: article_images
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  article_id :integer
#  image      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_article_images_on_article_id  (article_id)
#  index_article_images_on_user_id     (user_id)
#

class ArticleImage < ActiveRecord::Base
  mount_uploader :image, ArticleImageUploader

  belongs_to :user
  belongs_to :article

  validate :must_belongs_to_own_article

  # 自分以外の記事への画像アップロードは禁止
  def must_belongs_to_own_article
    if self.article.user_id != self.user_id
      errors.add(:article_id, :must_belongs_to_own_article)
    end
  end

end
