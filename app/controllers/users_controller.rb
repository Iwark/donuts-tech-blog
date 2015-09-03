# coding: utf-8

class UsersController < ApplicationController
  # GET /users/1
  def show(id, page=1)
    @user      = User.find(id)
    @articles  = @user.articles.approved_by_page(page)
  end
end
