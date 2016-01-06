# coding: utf-8

class Admin::ArticlesController < AdminController

  # GET /admin/articles
  def index(page = nil)
    @articles = Article.
                  where.not(status: [Article.statuses[:deleted]]).
                  order(created_at: :desc).
                  page(page).
                  per(20).
                  includes(:user)
  end

  # PATCH /admin/articles/:id/approve
  def approve(id)
    article = Article.find(id)
    article.status = :approved
    article.approved_at ||= Time.zone.now
    article.save
    redirect_to :admin_articles
  end
end
