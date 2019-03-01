class ListsController < ApplicationController
  before_action :set_board
  before_action :set_list, only: [:show, :destroy]

  def index
    @lists = @board.lists
  end

  def show

  end

  def new
    @list = List.new
  end

  def create
    @list = @board.lists.new(list_params)
    @list[:user_id] = current_user[:id]
    
    if @list.save
      flash[:success] = "list Created"
      redirect_to @board
    else
      flash[:error] = "Error #{@list.errors.full_messages.join("\n")}"
      render :new
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def set_board
      @board = current_user.boards.find(params[:board_id])
    end

    def list_params
      params.require(:list).permit(:name, :board_id, :user_id)
    end
end
