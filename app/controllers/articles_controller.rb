# coding: utf-8

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_resent_articles, only: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]
  permits :user, :title, :body

  # GET /articles
  def index(page = nil)
    @articles = Article.by_status(:approved).
                        order(created_at: :desc).
                        page(page).
                        per(1).
                        includes(:user)
  end

  # GET /articles/1
  def show
    redirect_to :root if @article.status != "approved"
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create(article)
    @article = Article.new(article)
    @article.user = current_user

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  # PUT /articles/1
  def update(article)
    if @article.update(article)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /articles/1
  def destroy
    @article.update(status: :deleted)

    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article(id)
      @article = Article.find(id)
    end

    def set_resent_articles
      @resent_articles = Article.by_status(:approved).
                        order(created_at: :desc).
                        limit(5).
                        includes(:user)
    end
end
