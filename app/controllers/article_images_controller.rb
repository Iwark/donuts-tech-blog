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

end
