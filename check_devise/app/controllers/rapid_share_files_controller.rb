class RapidShareFilesController < ApplicationController

      def index
          @files = RapidShareFile.where("user_id = ?", current_user.id)
      end

      def create
          u = RapidShareFile.new
	  u.user_id = current_user.id
          u.file = params[:file]
          if u.save
             flash[:notice] = "The file was saved successfully"
          else
             flash[:error] = "There was an error in saving the file. Please try again."
          end
          redirect_to rapid_share_files_path
      end

      def show
          @u = RapidShareFile.find(params[:id])
          send_file @u.file.current_path, filename: @u.file_identifier
      end

      def destroy
          @u = RapidShareFile.find(params[:id])
          @u.destroy
          redirect_to rapid_share_files_path
      end

end
