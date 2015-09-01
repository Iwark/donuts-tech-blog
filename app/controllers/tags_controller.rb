# coding: utf-8

class TagsController < ApplicationController
  # GET /tags/1
  def show(id, page=1)
    @tag             = Tag.find(id)
    @articles        = @tag.articles.approved_by_page(page)
    @resent_articles = @tag.articles.approved_by_page(1, 5)
  end
end
