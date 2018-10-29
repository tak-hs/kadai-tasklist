class TasksController < ApplicationController
  before_action :set_tasks, only: [:show, :edit, :update, :destroy]
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @tasks = Task.new
  end

  def create
    @tasks = current_user.tasks.build(tasks_params)
    if @tasks.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def edit
  end

  def update
    if @tasks.update(tasks_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @tasks.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end

  
  private
  
  def set_tasks
    @tasks = Task.find(params[:id])
  end

  # Strong Parameter
  def tasks_params
    params.require(:task).permit(:content, :status)
  end


  def correct_user
    @taskst = current_user.tasks.find_by(id: params[:id])
    unless @tasks
      redirect_to root_url
    end
  end

end
