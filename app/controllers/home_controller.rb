class HomeController < ApplicationController
  def index
    @posts = Post.where(approved:true)
  end

  def about
  end

  def search
  end

  def feedback
  end
end
