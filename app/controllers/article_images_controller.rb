# coding: utf-8

class ArticleImagesController < ApplicationController
  before_action :authenticate_user!
  permits :article_id, :image, :remote_image_url

  # AJAX POST /article_images
  def create(article_image)
    @article_image = ArticleImage.new(article_image)
    @article_image.user = current_user

    @article_image.save

    respond_to do |format| 
      format.html 
      format.js { render 'create.js.erb' }
    end

  end

  def upload(article_id)
    uploaded_files = []
    params.each do |k, v|
      if tmp = v.try(:tempfile)
        article_image = ArticleImage.create(
          article_id: article_id,
          user_id: current_user.id,
          image: File.open(tmp.path)
        )
        uploaded_files << article_image.image_url
      end
    end
    
    render json: uploaded_files
  end

end
