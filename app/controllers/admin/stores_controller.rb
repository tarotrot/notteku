class Admin::StoresController < Admin::Base
  # 店舗一覧
  def index
    @stores = Store.order(params[:id])#.page(params[:page]).per(15)
  end

  # 店舗情報の詳細
  def show
    @store = Store.find(params[:id])
  end

  # 店舗情報編集フォーム
  def edit
    @store = Store.find(params[:id])
  end

  # 店舗情報の更新
  def update
    @store = Store.find(params[:id])
    @store.assign_attributes(store_params)
    if @store.save
      redirect_to :admin_stores, notice: "店舗情報を更新しました。"
    else
      render "edit"
    end
  end

  # 店舗登録フォーム
  def new
    @store = Store.new
  end

  # 店舗の新規登録
  def create
    @store = Store.new(store_params)
    if @store.save
      redirect_to :admin_stores, notice: "店舗を登録しました。"
    else
      render "new"
    end
  end

  # 店舗の削除
  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to :admin_stores, notice: "店舗を削除しました。"
  end

  # ストロング・パラメータ
  private def store_params
    params.require(:store).permit(
      :store_code,
      :name,
      :start_time,
      :end_time,
      :address,
      :phone_number
    )
  end
end
