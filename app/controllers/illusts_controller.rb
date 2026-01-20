class IllustsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_illust, only: [ :show, :edit, :update, :destroy, :favorite ]

  def index
    @illusts = Illust.all

    if params[:q].present?
      @illusts = @illusts.search(params[:q])
    end

    if params[:sort].present?
      @illusts = @illusts.sorted(params[:sort])
    end
  end

  def show
  end

  def new
    @illust = Illust.new
  end

  def create
    @illust = current_user.illusts.build(illust_params)

    if @illust.save
      redirect_to @illust, notice: "イラストを投稿しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @illust.update(illust_params)
      redirect_to @illust, notice: "イラストを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @illust.destroy
    redirect_to illusts_path, notice: "イラストを削除しました"
  end

  def favorite
    favorite = current_user.favorites.find_by(illust_id: @illust.id)

    if favorite
      favorite.destroy
    else
      current_user.favorites.create(illust_id: @illust.id)
    end

    redirect_to @illust
  end

  private

  def set_illust
    @illust = Illust.find(params[:id])
  end

  def illust_params
    params.require(:illust).permit(:title, :description, :image)
  end
end
