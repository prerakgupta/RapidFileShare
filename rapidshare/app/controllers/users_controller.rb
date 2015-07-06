class UsersController < ApplicationController

      skip_before_action :require_login, :only => [:register, :create, :index, :login]      

      def index
      end

      def create
      	  user = User.new

	  if params[:password]!=params[:password_confirmation]
	     flash[:error] = "The password entered do not match"
	     redirect_to register_users_path

	  else   
	  	 user.username = params[:username]
       	  	 user.salt = SecureRandom.base64(6)

	  	 user.password = encrypt_password(user.salt, params[:password])
	  	 if user.save
	     	    session[:current_user_id] = user.id
	     	    session[:username] = user.username
	     	    redirect_to rapid_share_files_url
	  	 else
			flash[:error] = user.errors.messages
	     		redirect_to register_users_path  	   
	  	  end
          end		  
      end

      def register
      end

      def login
      	  @user = User.find_by_username(params[:username])
	  if @user.blank?
             flash[:error] = "Inavlid Username"
	     redirect_to users_url
	  elsif @user.password.eql? encrypt_password(@user.salt, params[:password])
              session[:current_user_id] = @user.id
	      session[:username] = @user.username			 
	      redirect_to rapid_share_files_url
	  else
	     flash[:error] = "Wrong password"
	     redirect_to users_url    
	  end   			
      end

      def logout
      	  reset_session
	  @@logged_in = false
	  redirect_to users_path
      end

      private

	def encrypt_password(salt, password)
	    pwd = Digest::SHA2.hexdigest(salt + password)
	    return pwd
	end
end
