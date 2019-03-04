class TasksController < ApplicationController
  before_action :set_list
  before_action :set_board
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @list.tasks
  end

  def show
    # @appointments = 
  end

  def new
    @task = Task.new
    $previous_url = request.referer
  end

  def create
    @task = @list.tasks.new(task_params)
    @task[:board_id] = @list[:board_id]
    @task[:user_id] = current_user[:id]

    if @task.save
      flash[:success] = "Task Created"
      redirect_to $previous_url
    else
      flash[:error] = "Error #{@task.errors.full_messages.join("\n")}"
      render :new
    end
  end

  def edit
    $previous_url = request.referer
  end

  def update
    if @task.update(task_params)
      flash[:success] = "Task Updated"
      redirect_to $previous_url
    else  
      flash[:error] = "Error #{@task.errors.full_messages.join("\n")}"
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to board_list_path(@board, @list)
  end

  private
    # List must be set first, even though the board is the parent
    def set_list
      @list = List.find(params[:list_id])
    end

    # From here, the board_id can be derived, and stored for use in the controller above
    def set_board
      @board = current_user.boards.find(@list[:board_id])
    end

    # Finally, for instances which need it, the task can be used.
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :details, :due_date, :due_time, :completed)
    end

end
