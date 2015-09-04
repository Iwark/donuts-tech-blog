class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_view_path
  before_action :meta_defaults

  # 存在チェック
  def health
    render nothing: true
  end

  private
    def set_view_path
      path =  request.smart_phone? ? 'sp' : 'pc'
      prepend_view_path(['app/views/common', "app/views/#{path}"])
    end

    def meta_defaults
      @meta_title = "Donuts Tech Blog｜エンジニア集団Donuts"
      @meta_description = "新規のWebサービスやゲームで用いられている新しい技術や、何年も運用を続けているWebサービスやゲームのノウハウなどを紹介していきます。"
      @meta_keywords = "Donuts,ドーナツ,技術ブログ,エンジニア,新規技術,運用ノウハウ"
      @meta_og_image = AURI.join(root_url, ActionController::Base.helpers.image_url('logo_color.png'))
    end

end
