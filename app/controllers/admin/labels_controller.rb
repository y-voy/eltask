class Admin::LabelsController < ApplicationController

  before_action :requier_admin
  before_action :set_label, only: [:show, :edit, :update, :destroy]

  def index
    @labels = Label.all.page(params[:page])
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to admin_labels_path, notice: "ラベル「#{@label.name}」を登録しました。"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @label.update(label_params)
      redirect_to admin_labels_path, notice: "ラベル「#{@label.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    redirect_to admin_labels_path, notice: "ラベル「#{@label.name}」を削除しました。"
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end

  def set_label
    @label = Label.find(params[:id])
  end

  def requier_admin
    redirect_to tasks_path, notice: "管理者以外はアクセスできません" unless current_user.admin?
  end

end
