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

require 'rails_helper'

RSpec.describe Article, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
