class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
    @tasks = Task.all
  end

  def create
    @task = Task.new(params.require(:task).permit(:title, :start_date, :end_date, :all_day, :description))
    if @task.save
      format.html { redirect_to tasks_index_path, notice: "スケジュールを新規登録しました" }
      flash.now[:notice] = "スケジュールを新規登録しました"
      redirect_to tasks_index_path
    else
      flash.now[:danger] = "作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @tasks = Task.all
    @task = Task.find(params[:id])
  end

  def edit
    @tasks = Task.all
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(params.require(:task).permit(:title, :strat_date, :end_date, :all_day, :description))
      redirect_to tasks_index_path, success: "スケジュールを更新しました"
    else
      flash.now[:danger] = "編集に失敗しました"
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash.now[:notice] = "スケジュールを削除しました"
    redirect_to tasks_index_path
  end

end
