# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(255)      default(""), not null
#  encrypted_password :string(255)      default(""), not null
#  sign_in_count      :integer          default(0), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string(255)
#  last_sign_in_ip    :string(255)
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  authority          :integer          default(0)
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable, :omniauthable

  # 権限
  # normal
  # admin
  enum authority: { normal: 0, admin: 30 }
  validates :authority, inclusion: {in: %w(normal admin)}

  # @donuts.ne.jpで終わるメールアドレスのみを許容する
  validates :email, format: /@donuts\.ne\.jp\z/

  has_many :articles

  def administrator?
    self.authority == "admin"
  end

  def self.find_for_google_oauth2(auth)
    user = User.where(email: auth.info.email).first

    unless user
      user = User.create(
        name:     auth.info.name,
        email:    auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

end
