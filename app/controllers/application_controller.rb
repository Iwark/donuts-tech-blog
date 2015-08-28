class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_view_path

  # 存在チェック
  def health
    render nothing: true
  end

  private
    def set_view_path
      path =  request.smart_phone? ? 'sp' : 'pc'
      prepend_view_path(['app/views/common', "app/views/#{path}"])
    end

end
