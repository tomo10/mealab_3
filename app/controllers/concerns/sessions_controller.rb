class SessionsController < ApplicationController

    #login
    def new
    end

    #post from login
    def create
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path
      else
        flash[:errors] = ["Invalid username or password"]
        redirect_to login_path
      end
    end

    #logout
    def destroy
      session[:user_id] = nil
      redirect_to login_path
    end


end
