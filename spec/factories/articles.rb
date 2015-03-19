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

FactoryGirl.define do
  factory :article do
    user nil
title "MyString"
body "MyText"
  end

end
