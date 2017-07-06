class BoardsController < ApplicationController

  def index
     @boards = Board.all
   end

   def new
     @board = Board.new
   end

   def show
     @board = Board.find(params[:id])
   end

   def create
     @board = Board.new(board_params)
     if @board.save
       @board.users << current_user
       redirect_to board_path(@board)
     else
       render 'new'
     end
   end

   def destroy
   end

   private

     def board_params
       params.require(:board).permit(:name, :info)
     end

 end
