class HomeController < ApplicationController
  before_action :require_login
  
  def index
    @posts = Post.all.reverse
  end

  def comment_write
    comment = Comment.new
    comment.content = params[:comment]
    comment.post_id = params[:post_id]
    comment.save

    redirect_to '/home/index'
  end

  def write
    post = Post.new
    post.title = params[:title]
    post.content = params[:content]
    post.account = current_account

    uploader = ShooterUploader.new
    file = params[:pic]
    uploader.store!(file)

    post.image_path = uploader.url

    if post.save
      redirect_to '/home/index'
    else
      render :text => post.errors.messages
    end

  end

end
