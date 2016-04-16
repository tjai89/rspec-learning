class TasksController < ApplicationController
  def create
    @task = Task.new(
      params[:task].permit(:project_id, :title, :size))
    redirect_to @task.project
  end
end
