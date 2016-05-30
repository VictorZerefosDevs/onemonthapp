class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
      @post = current_user.posts.build
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)   
      if @post.save
       redirect_to @post, notice: 'Post was successfully created.' 
      else
       render :new 
      end
  end

  def update
      if @post.update(post_params)
       redirect_to @post, notice: 'Post was successfully updated.' 
      else
       render :edit 
      end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, notice: "This post does not belong to you." if @post.nil?
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
