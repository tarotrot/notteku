class AccountsController < ApplicationController
  before_action :login_required, except: [:new, :create]

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.assign_attributes(params[:account])
    if @user.save
      redirect_to :account, notice: "アカウント情報を更新しました。"
    else
      render "edit"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:account])
    if @user.save
      user = User.find_by(name: @user.name)
      cookies[:user_id] = user.id
      redirect_to root_path, notice: "ユーザを登録しました。"
    else
      render "new"
    end
  end

  # ユーザの削除
  def destroy
    @user = current_user
    @user.destroy
      cookies.delete(:user_id)
      redirect_to root_path, notice: "ユーザを削除しました。"
    end
end
