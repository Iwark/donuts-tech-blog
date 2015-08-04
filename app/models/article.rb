# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  body       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer          default(0)
#  series_id  :integer
#
# Indexes
#
#  index_articles_on_series_id  (series_id)
#  index_articles_on_user_id    (user_id)
#

class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :series

  has_many :article_tags
  has_many :tags, through: :article_tags

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :title, to: :series, prefix: true, allow_nil: true

  # 状態
  # temp      下書き
  # disclosed 公開申請
  # approved  公開
  # deleted   削除済み
  enum status: {temp: 0, disclosed: 10, approved: 20, deleted: 40}

  scope :by_status, -> status {
    where(status: statuses[status])
  }

  def public?
    status == "approved"
  end

end
