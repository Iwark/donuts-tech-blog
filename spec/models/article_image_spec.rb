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

require 'rails_helper'

RSpec.describe ArticleImage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
