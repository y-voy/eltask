class TasksController < ApplicationController

  before_action :set_task, only: [:show]

  def index
    @tasks = Task.all
  end

  def new
  end

  def show
  end

  def edit
  end

  def destoy
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
