# coding: utf-8

class ArticlesController < ApplicationController

  include ApplicationHelper

  before_action :set_resent_articles, only: [:index, :show]

  # GET /articles
  def index(page=1)
    @articles = Article.approved_by_page(page)
  end

  # GET /articles/1
  def show(id)
    @article = Article.find(id)
    redirect_to :root if @article.status != "approved" && !user_signed_in?

    @meta_title = @article.title
    @meta_description = ActionController::Base.helpers.sanitize(markdown(@article.body), tags: []).truncate(140)
    @meta_og_image = @article.image_url if @article.image_url

  end

  private
    def set_resent_articles
      @resent_articles = Article.by_status(:approved).
                        order(created_at: :desc).
                        limit(5)
    end
end
