# coding: utf-8

class Admin::SeriesController < AdminController

  before_action :set_series, only: [:edit, :update]
  permits :title, :description

  # GET /admin/series
  def index(page=1)
    @series = Series.all.page(page).per(20)
  end

  def new
    @series = Series.new
  end

  def edit
  end

  def create(series)
    @series = Series.new(series)

    if @series.save
      redirect_to admin_series_index_path, notice: 'Series was successfully created.'
    else
      render :new
    end

  end

  def update(series)
    if @series.update(series)
      redirect_to admin_series_index_path, notice: 'Series was successfully updated.'
    else
      render :edit
    end
  end

  private
  def set_series(id)
    @series = Series.find(id)
  end

end