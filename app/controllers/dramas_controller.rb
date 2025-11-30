class DramasController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_drama, only: [:show, :edit, :update, :destroy]
  before_action :set_dramas_scope, only: [:index]

  def index; end

  def show; end

  def new
    @drama = Drama.new
  end

  def edit; end

  def create
    @drama = current_user.dramas.new(drama_params)
    if @drama.save
      redirect_to @drama, notice: "ドラマを登録しました"
    else
      render :new
    end
  end

  def update
    if @drama.update(drama_params)
      redirect_to @drama, notice: "ドラマを更新しました"
    else
      render :edit
    end
  end

  def destroy
    if @drama.user == current_user
      @drama.destroy
      redirect_to dramas_path, notice: "ドラマを削除しました"
    else
      redirect_to dramas_path, alert: "削除できませんでした"
    end
  end

  private

  def set_drama
    @drama = Drama.find(params[:id])
  end

  def set_dramas_scope
    drama_scope = user_signed_in? ? current_user.dramas : Drama.public_dramas
    @dramas = drama_scope
              .title_search(params[:title])
              .genre_search(params[:genre])
              .mood_search(params[:mood])
              .watched_on_search(params[:watched_on])
  end

  def drama_params
    params.require(:drama).permit(:title, :genre, :description, :watched_on, :mood, :scene, :is_public)
  end
end
