class RapidShareFilesController < ApplicationController
      
      skip_before_filter :verify_authenticity_key, :only => [:index, :create] 
      
      def index
      	  @all_files = RapidShareFile.where("user_id = ?", session[:current_user_id] )
      end

      def new
      end
      
      def show
      	  @current_file = RapidShareFile.find(params[:id])
	  if @current_file.user_id==session[:current_user_id]
	     send_data @current_file.file, filename: @current_file.title
	  else
             flash[:error] = "You are not authenticated to perform this action."		   
	  end
      end

      def create
      	  if !params.has_key?(:file)
	     flash[:error] = "Please select a file"
	     redirect_to action: "index"
	  else	
	  	new_file = RapidShareFile.new
	  	new_file.title = params[:file].original_filename
	  	new_file.file = params[:file].read
		new_file.user_id = session[:current_user_id]
	  	if new_file.save
		   flash[:notice] = "Your file has been saved successfully!"
		   redirect_to action: "index"
		else
		   flash[:error] = "There was a problem submitting your attachment. Please try again."
		   redirect_to action: "index"
		end  	
          end
      end
      
      def destroy
      	  @file = RapidShareFile.find(params[:id])
	  if @file.user_id==session[:current_user_id]
	     @file.destroy
	  else
	     flash[:error] = "You are not authenticated to delete this file."   
	  end
	  redirect_to rapid_share_files_url
      end
end
