class RapidShareFilesController < ApplicationController
      def index
      	  @all_files = RapidShareFile.all
      end

      def new
      end
      
      def show
      	  @current_file = RapidShareFile.find(params[:id])
	  send_data @current_file.file, filename: @current_file.title
      end

      def create
      	  if !params.has_key?(:file)
	     flash[:error] = "Please select a file"
	     redirect_to action: "new"
	  else	
	  	new_file = RapidShareFile.new
	  	new_file.title = params[:file].original_filename
	  	new_file.file = params[:file].read
	  	if new_file.save
		   flash[:notice] = "Your file has been saved successfully!"
		   redirect_to action: "index"
		else
		   flash[:error] = There was a problem submitting your attachment. Please try again.
		   redirect_to action: "new"
		end  	
          end
      end
      
      def destroy
      	  @file = RapidShareFile.find(params[:id])
	  @file.destroy
	  
	  redirect_to action: "index"
      end
end
