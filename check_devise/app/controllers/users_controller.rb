class UsersController < ApplicationController

      def index
      	  if user_signed_in?
		render plain: current_user.id.inspect
	  else
		render plain: "index not signed in"
	  end			
      end

      def new
      	  render plain: "new"
      end

      def create
      	  render plain: "create"
      end	  	  

end
