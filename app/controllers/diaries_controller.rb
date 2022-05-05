class DiariesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @diaries = Diary.all
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)
    @diary.user_id = current_user.id
    if @diary.save
      redirect_to diary_path(@diary), notice: '投稿に成功しました。'
    else
      render :new
    end
  end

  def edit
    @diary = Diary.find(params[:id])
    if @diary.user != current_user
      redirect_to diaries_path, alert: '不正なアクセスです。'
    end
  end

  def update
    @diary = Diary.find(params[:id])
    if @diary.update(diary_params)
      redirect_to diary_path(@diary), notice: '投稿に成功しました。'
    else
      render :edit
    end
  end

  def destroy
    diary = Diary.find(params[:id])
    if diary.destroy
      redirect_to diaries_path
    else
      render 'index'
    end
  end

  private
  def diary_params
    params.require(:diary).permit(:title, :body, :image)
  end

end
