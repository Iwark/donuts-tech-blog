# coding: utf-8

class Admin::TagsController < AdminController

  before_action :set_tag, only: [:edit, :update]
  permits :name

  # GET /admin/tags
  def index(page=1)
    @tags = Tag.all.page(page).per(20)
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create(tag)
    @tag = Tag.new(tag)

    if @tag.save
      redirect_to admin_tags_path, notice: 'Tag was successfully created.'
    else
      render :new
    end

  end

  def update(tag)
    if @tag.update(tag)
      redirect_to admin_tags_path, notice: 'Tag was successfully updated.'
    else
      render :edit
    end
  end

  private
  def set_tag(id)
    @tag = Tag.find(id)
  end

end