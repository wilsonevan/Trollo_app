class TasksController < ApplicationController
  before_action :set_list
  before_action :set_board

  before_action :set_task, only: [:show, :destroy]

  def index
    @tasks = @list.tasks
  end

  def show
    # @appointments = 
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = "Task Created"
      redirect_to root_path # => task_path(@task)
    else
      flash[:error] = "Error #{@task.errors.full_messages.join("\n")}"
      render :new
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    def set_board
      @board = Board.find(params[:board_id])
    end

    def task_params
      params.require(:task).permit(:name)
    end
end
