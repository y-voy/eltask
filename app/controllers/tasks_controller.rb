class TasksController < ApplicationController

  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:task].present?
      if params[:task][:name].present? && params[:task][:status].present?
        status = params[:task][:status]
        @tasks = Task.where('name LIKE ?', "%#{params[:task][:name]}%").where(status: Task.statuses[status])
      elsif params[:task][:name].present?
        @tasks = Task.where('name LIKE ?', "%#{params[:task][:name]}%")
      elsif params[:task][:status].present?
        status = params[:task][:status]
        @tasks = Task.where(status: Task.statuses[status])
      else
        @tasks = Task.all.order(created_at: :desc)
      end
    else
      if params[:sort_expired]
        @tasks = Task.all.order(expired_at: :asc)
      else
        @tasks = Task.all.order(created_at: :desc)
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task.id), notice: "作成しました！"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :expired_at, :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
