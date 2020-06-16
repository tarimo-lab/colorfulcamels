class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def show
    @posts = @user.posts;
  end

end