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

FactoryGirl.define do
  factory :tag do
    name "MyString"
parent_id 1
lft 1
rgt 1
depth 1
children_count 1
articles_count 1
  end

end
