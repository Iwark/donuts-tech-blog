# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string(255)
#  body        :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :integer          default(0)
#  series_id   :integer
#  approved_at :datetime
#
# Indexes
#
#  index_articles_on_approved_at  (approved_at)
#  index_articles_on_series_id    (series_id)
#  index_articles_on_user_id      (user_id)
#

class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :series

  has_many :article_tags
  has_many :tags, through: :article_tags
  has_many :article_images

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :title, to: :series, prefix: true, allow_nil: true

  # 状態
  # temp      初期化状態
  # draft     下書き
  # disclosed 公開申請
  # approved  公開
  # deleted   削除済み
  enum status: {temp: 0, draft: 10, disclosed: 20, approved: 30, deleted: 40}

  scope :by_status, -> status {
    where(status: statuses[status])
  }

  scope :approved_by_page, -> page, per=10 {
    by_status(:approved).
    order(approved_at: :desc).
    page(page).
    per(per).
    includes([:user, :series, :tags])
  }

  scope :between, -> from, to {
    where(arel_table[:created_at].gt(from)).
    where(arel_table[:created_at].lt(to))
  }

  def image_url
    return nil unless self.body
    m = self.body.match(/\!\[.*?\]\((.*?)\)/)
    m ? m[1] : nil
  end

  def public?
    status == "approved"
  end

  # 限定公開用のkey
  def key
    Digest::SHA1.hexdigest("key_of_article_#{id}")[0..7]
  end

end
