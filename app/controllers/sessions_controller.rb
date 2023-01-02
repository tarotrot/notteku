class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      cookies[:user_id] = user.id
    else
      flash.alert = "emailとパスワードが一致しません"
    end
    redirect_to request.referer
  end


  def destroy
    cookies.delete(:user_id)
    redirect_to :root
  end
end
