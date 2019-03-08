class ListsController < ApplicationController
  before_action :set_board, except: [:destroy]
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    # @lists = @board.lists
    render json: @board.lists
  end

  def show
    # render json: @list
  end

  def new
    @list = List.new
    # render partial: "form"
  end

  def create
    @list = @board.lists.new(list_params)
    @list[:user_id] = current_user[:id]
    
    if @list.save
      flash[:success] = "list Created"
      redirect_to @board
      # render json: @list
    else
      flash[:error] = "Error #{@list.errors.full_messages.join("\n")}"
      render :new
      # render_error(@list)
    end
  end

  def edit
    
  end

  def update
    @list[:user_id] = current_user[:id]

    if @list.update(list_params)
      flash[:success] = "Task Updated"
      redirect_to @board
      # render json: @list
    else
      flash[:error] = "Error #{@list.errors.full_messages.join("\n")}"
      render :edit
      # render_error(@list)
    end
  end

  def destroy
    if @list.destroy
      flash[:error] = "Error #{@list.errors.full_messages.join("\n")}"
      render json: { message: 'removed' }, status: :ok
    else
      flash[:error] = "Error #{@list.errors.full_messages.join("\n")}"
      redirect_to request.referer
    end
  end

  private
    def set_list
      @list = List.find(params[:id])
      # binding.pry
    end

    def set_board
      @board = current_user.boards.find(params[:board_id])
    end

    def list_params
      params.require(:list).permit(:name, :board_id, :user_id)
    end
end
