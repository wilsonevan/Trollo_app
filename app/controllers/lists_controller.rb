class ListsController < ApplicationController
  before_action :set_board
  before_action :set_list, only: [:show, :destroy]

  def index
    @lists = @board.lists
  end

  def show
    # @appointments = 
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)

    if @list.save
      flash[:success] = "list Created"
      redirect_to root_path # => list_path(@list)
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
      @board = Board.find(params[:board_id])
    end

    def list_params
      params.require(:list).permit(:name)
    end
end
