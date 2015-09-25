# coding: utf-8

class Users::ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: [:edit, :update, :destroy]
  permits :title, :body, :series_id, tag_ids: []

  # GET /my_articles
  def index(page=1)
    @articles = current_user.articles.
                  where.not(status: [Article.statuses[:temp], Article.statuses[:deleted]]).
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
  def update(article, preview=false)
    @article.status = 'draft' if @article.status == 'temp' && !preview
    @article.tags = Tag.where(id: article['tag_ids'].map(&:to_i))
    if @article.update(article)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article.update(status: :deleted)

    redirect_to users_articles_url, notice: 'Article was successfully destroyed.'
  end

  # AJAX: タグ削除
  def destroy_tag(id, tag_id)
    if curator_signed_in?
      if @article_tag = ArticleTag.find_by(article_id: id, tag_id: tag_id)
        if current_user.administrator? || @article_tag.article.user_id == current_user.id
          @article_tag.destroy
        end
      end
    end
  end

  private
    def set_article(id)
      @article = Article.find(id)
    end
end
