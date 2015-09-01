# coding: utf-8

class SeriesController < ApplicationController
  # GET /series/1
  def show(id, page=1)
    @series          = Series.find(id)
    @articles        = @series.articles.approved_by_page(page)
    @resent_articles = @series.articles.approved_by_page(1, 5)
  end
end
