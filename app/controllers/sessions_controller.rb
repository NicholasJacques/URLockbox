class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: session_params['email'])

    if @user && @user.authenticate(session_params['password'])
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as #{@user.email}"
      redirect_to root_path
    else
      flash[:failure] = 'Login Unsuccessful'
      redirect_to new_session_path
    end
  end

  def destroy
    session.clear
    redirect_to new_session_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
