class UsersController < ApplicationController

      def index
      	  @files = User.all
      end

      def create
      	  u = User.new
	  u.username = "prerak"
	  u.file = params[:file]
	  if u.save
	     flash[:notice] = "The file was saved successfully"
	  else
	     flash[:error] = "There was an error in saving the file. Please try again."
	  end   
	  redirect_to users_path   	  	  
      end

      def show
      	  @u = User.find(params[:id])
	  send_file @u.file.current_path, filename: @u.file_identifier
      end

      def destroy
      	  @u = User.find(params[:id])
	  @u.destroy
	  redirect_to users_path
      end
end
