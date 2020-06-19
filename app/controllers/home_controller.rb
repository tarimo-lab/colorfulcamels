class HomeController < ApplicationController
  def index
    @posts = Post.where(approved:true, public:true).paginate(:page => params[:page]).order('id DESC')
  end

  def about
  end

  def search
  end

  def feedback
  end
end
