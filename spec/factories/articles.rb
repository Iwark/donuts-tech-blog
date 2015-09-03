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

FactoryGirl.define do
  factory :article do
    user nil
title "MyString"
body "MyText"
  end

end
