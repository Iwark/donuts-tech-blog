class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin_user!

  # 管理権限のあるユーザーであることの認証
  def authenticate_admin_user!
    redirect_to :root unless current_user.authority == "admin"
  end

end
