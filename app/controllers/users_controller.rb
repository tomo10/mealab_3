class UsersController < ApplicationController



  def show
    authorized_for(params[:id])
    @user = User.find(params[:id])
  end


  def new
    @user = User.new
  end


  def create
    user = User.new(user_params)
    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect_to user
    else
      flash[:errors] = ["Something went wrong, please try again"]
      redirect_to signup_path
  end
end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :password)
  end



end
