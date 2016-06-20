class HomeController < ApplicationController
  def index
    if account_signed_in?
      @posts = Post.all.reverse
    else
      redirect_to '/accounts/sign_in'
    end
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
