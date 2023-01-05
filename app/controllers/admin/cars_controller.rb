class Admin::CarsController < Admin::Base
  # 車一覧
  def index
    @cars = Car.order(params[:id])#.page(params[:page]).per(15)
  end

  # 車情報の詳細
  def show
    @car = Car.find(params[:id])
  end

  # 車情報編集フォーム
  def edit
    @car = Car.find(params[:id])
  end

  # 車情報の更新
  def update
    @car = Car.find(params[:id])
    @car.assign_attributes(car_params)
    if @car.save
      redirect_to :admin_cars, notice: "車情報を更新しました。"
    else
      render "edit"
    end
  end

  # 車登録フォーム
  def new
    @car = Car.new
  end

  # 車の新規登録
  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to :admin_cars, notice: "車を登録しました。"
    else
      render "new"
    end
  end

  # 車の削除
  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    redirect_to :admin_cars, notice: "車を削除しました。"
  end

  # ストロング・パラメータ
  private def car_params
    params.require(:car).permit(
      :car_code,
      :car_type,
      :store_id,
      :name,
      :status,
      :price
    )
  end
end
