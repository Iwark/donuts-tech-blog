# coding: utf-8

class Admin::UsersController < AdminController

  before_action :set_user, only: [:edit, :update]
  permits :name, :authority

  # GET /admin/users
  def index(page=1)
    @users = User.order(created_at: :desc).page(page).per(10)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create(user)
    @user = User.new(user)

    if @user.save
      redirect_to admin_users_path, notice: 'User was successfully created.'
    else
      render :new
    end

  end

  def update(user)
    if @user.update(user)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private
  def set_user(id)
    @user = User.find(id)
  end

end
