class Admin::PricelistsController < Admin::Base
  # 料金表
  def index
    @pricelists = Pricelist.order(params[:id])#.page(params[:page]).per(15)
  end

  # 料金編集フォーム
  def edit
    @pricelist = Pricelist.find(params[:id])
  end

  # 料金情報の更新
  def update
    @pricelist = Pricelist.find(params[:id])
    @pricelist.assign_attributes(params[:pricelist])
    if @pricelist.save
      redirect_to :admin_pricelists, notice: "料金表の項目を更新しました。"
    else
      render "edit"
    end
  end

  # 期間料金登録フォーム
  def new
    @pricelist = Pricelist.new
  end

  # 期間料金の新規登録
  def create
    @pricelist = Pricelist.new(params[:pricelist])
    if @pricelist.save
      redirect_to :admin_pricelists, notice: "料金表に項目を登録しました。"
    else
      render "new"
    end
  end

  # 料金表の項目の削除
  def destroy
    @pricelist = Pricelist.find(params[:id])
    @pricelist.destroy
    redirect_to :admin_pricelists, notice: "料金表の項目を削除しました。"
  end
end
