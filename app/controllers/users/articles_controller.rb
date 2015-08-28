# coding: utf-8

class Users::ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: [:edit, :update, :destroy]
  permits :title, :body, :series_id

  # GET /my_articles
  def index(page=1)
    @articles = current_user.articles.
                  order(created_at: :desc).
                  page(page).
                  per(20).
                  includes(:series)
  end

  # GET /articles/new
  def new
    @article = Article.find_or_create_by(user_id: current_user.id, status: Article.statuses[:temp])
    @article_images = @article.article_images
  end

  # GET /articles/1/edit
  def edit
    @article_images = @article.article_images
  end

  # PUT /articles/1
  def update(article)
    @article.status = 'draft' if @article.status == 'temp'
    if @article.update(article)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article.update(status: :deleted)

    redirect_to admin_articles_url, notice: 'Article was successfully destroyed.'
  end

  private
    def set_article(id)
      @article = Article.find(id)
    end
end
