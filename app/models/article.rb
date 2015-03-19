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
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#

class Article < ActiveRecord::Base
  belongs_to :user
  delegate :name, to: :user, prefix: true, allow_nil: true

  # 状態
  # temp      下書き
  # disclosed 公開申請
  # approved  公開
  # deleted   削除済み
  enum status: {temp: 0, disclosed: 10, approved: 20, deleted: 40}

  scope :by_status, -> status {
    where(status: statuses[status])
  }

end
