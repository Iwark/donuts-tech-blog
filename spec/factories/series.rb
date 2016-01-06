# == Schema Information
#
# Table name: series
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :series do
    title "MyString"
description "MyString"
  end

end
