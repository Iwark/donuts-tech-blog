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

class Series < ActiveRecord::Base
  has_many :articles
end
