# coding: utf-8

class Admin::ArticlesController < AdminController

  # GET /admin/articles
  def index(page = nil)
    @articles = Article.order(created_at: :desc).page(page).per(10).includes(:user)
  end

  def approve(article_id)
    Article.find(article_id).update(status: :approved)
    redirect_to :admin_articles
  end
end
