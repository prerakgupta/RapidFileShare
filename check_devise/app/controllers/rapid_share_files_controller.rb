class RapidShareFilesController < ApplicationController

      before_filter :check_file_availability, :only => [:show, :destroy]
      before_filter :check_authencity_of_user, :only => :destroy


      def index
          @files = RapidShareFile.all;
      end

      def create
          if user_signed_in?
            u = RapidShareFile.new
	          u.user_id = current_user.id
            u.file = params[:file]
              if !u.save
                flash[:error] = "There was an error in saving the file. Please try again."
              end
            redirect_to rapid_share_files_path
          else
            redirect_to destroy_user_session_path
          end

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

      protected
        def check_authencity_of_user
            @file = RapidShareFile.find(params[:id]);
            if current_user.id!=@file.user_id
              flash[:error] = "You are not authorised to delete this."
              redirect_to rapid_share_files_path
            end
        end

        def check_file_availability
          if !RapidShareFile.exists?(params[:id])
              flash[:error] = "The file with the given id does not exist.";
              redirect_to rapid_share_files_path
          end
        end
end
