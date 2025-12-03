class IllustsController < ApplicationController
  before_action :require_login
  before_action :set_illust, only: [:show, :edit, :update, :destroy, :favorite]

  # -----------------------------
  # イラスト一覧（検索 + ソート）
  # -----------------------------
  def index
    @illusts = Illust.all

    # 🔍 検索（タイトル部分一致）
    if params[:q].present?
      keyword = "%#{params[:q]}%"
      @illusts = @illusts.where("title LIKE ?", keyword)
    end

    # ⇅ ソート
    case params[:sort]
    when "title_asc"
      @illusts = @illusts.order(title: :asc)
    when "title_desc"
      @illusts = @illusts.order(title: :desc)
    when "old"
      @illusts = @illusts.order(created_at: :asc)
    else
      # デフォルト：新着順
      @illusts = @illusts.order(created_at: :desc)
    end
  end

  # 詳細
  def show
  end

  # 新規投稿
  def new
    @illust = Illust.new
  end

  # 作成
  def create
    @illust = Illust.new(illust_params)
    @illust.user_id = current_user.id

    if @illust.save
      redirect_to @illust, notice: "イラストを投稿しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 編集
  def edit
  end

  # 更新
  def update
    if @illust.update(illust_params)
      redirect_to @illust, notice: "イラストを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 削除
  def destroy
    @illust.destroy
    redirect_to illusts_path, notice: "イラストを削除しました"
  end

  # お気に入り登録/解除
  def favorite
    if current_user.favorites.exists?(illust_id: @illust.id)
      current_user.favorites.find_by(illust_id: @illust.id).destroy
      notice = "お気に入りを解除しました"
    else
      current_user.favorites.create(illust_id: @illust.id)
      notice = "お気に入りに追加しました"
    end
    redirect_to @illust, notice: notice
  end

  private

  def set_illust
    @illust = Illust.find(params[:id])
  end

  def illust_params
    params.require(:illust).permit(:title, :description, :image)
  end

  # --- ログインしていないユーザを弾く ---
  def require_login
    unless current_user
      redirect_to login_path, alert: "ログインしてください"
    end
  end
end
