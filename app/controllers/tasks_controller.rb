class TasksController < ApplicationController

  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_task_label, only: [:edit]

  def index
    if params[:task].present?
      if params[:task][:name].present? && params[:task][:status].present?
        status = params[:task][:status]
        @tasks = current_user.tasks.where('name LIKE ?', "%#{params[:task][:name]}%").where(status: Task.statuses[status]).page(params[:page])
      elsif params[:task][:name].present?
        @tasks = current_user.tasks.where('name LIKE ?', "%#{params[:task][:name]}%").page(params[:page])
      elsif params[:task][:status].present?
        status = params[:task][:status]
        @tasks = current_user.tasks.where(status: Task.statuses[status]).page(params[:page])
      else
        @tasks = current_user.tasks.all.order(created_at: :desc).page(params[:page])
      end
    else
      if params[:sort_expired]
        @tasks = current_user.tasks.all.order(expired_at: :asc).page(params[:page])
      elsif params[:sort_priority]
        @tasks = current_user.tasks.all.order(priority: :desc).page(params[:page])
      elsif params[:sort_status]
        @tasks = current_user.tasks.all.order(status: :asc).page(params[:page])
      else
        @tasks = current_user.tasks.all.order(created_at: :desc).page(params[:page])
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:name, :description, :expired_at, :status, :priority, { label_ids: [] } ).merge(user_id: current_user.id)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def set_task_label
    @task = current_user.tasks.find(params[:id])
    @labels = @task.labels.all
  end

end
