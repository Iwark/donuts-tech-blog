# coding: utf-8

class ArticlesController < ApplicationController
  before_action :set_resent_articles, only: [:index, :show]

  # GET /articles
  def index(page=1)
    @articles = Article.approved_by_page(page)
  end

  # GET /articles/1
  def show(id)
    @article = Article.find(id)
    redirect_to :root if @article.status != "approved" && !user_signed_in?
  end

  private
    def set_resent_articles
      @resent_articles = Article.by_status(:approved).
                        order(created_at: :desc).
                        limit(5)
    end
end
