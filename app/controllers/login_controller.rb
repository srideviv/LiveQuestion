class LoginController < ApplicationController

  def index
    @user = User.new
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def login
    session[:current_user_id] = nil
    session[:admin_user] = nil
    @user = User.find_by_uname(params[:uname])
    if @user == nil || !@user.authenticate(params[:uname], params[:password])
      flash[:alert] = "Unable to log in to the system. Please check your credentials"
      redirect_to :action => "index"
    elsif @user.authenticate(params[:uname], params[:password])
      session[:current_user_id] = @user.id
      flash[:notice] = "Successfully Logged in"
      if @user.admin_perm?
        session[:admin_user] = true
        flash[:notice] = "Admin logged in"
      end
      redirect_to(:controller => "posts", :action => "index")
      end
  end

  def logout
    session[:current_user_id] = nil
    session[:admin_user]= nil
    flash[:alert] = "Successfully Logged out"
    redirect_to :action => "index"
  end
end