class Admin::UsersController < Admin::Base
  # ユーザ一覧
  def index
    @users = User.order(params[:id])#.page(params[:page]).per(15)
  end

  # ユーザ情報の詳細
  def show
    @user = User.find(params[:id])
  end

  # 編集フォーム
  def edit
    @user = User.find(params[:id])
  end

  # ユーザ情報の更新
  def update
    @user = User.find(params[:id])
    @user.assign_attributes(params[:user])
    if @user.save
      redirect_to [:admin, @user], notice: "会員情報を更新しました。"
    else
      render "edit"
    end
  end

  # ユーザの削除
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :admin_users, notice: "会員を削除しました。"
  end
end
