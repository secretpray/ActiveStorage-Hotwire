class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i(index show) do
    redirect_to new_user_session_path unless current_user
  end

  def index
    @posts = Post.recent
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        flash.now[:notice] = "Post '#{@post.title}' created!"
        render_flash
        format.html { redirect_to posts_path }
        format.json { render :show, status: :created, location: @post }
      else
        flash.now[:error] = @post.errors.full_messages.join(', ')
        render_flash
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        flash.now[:notice] = "Post '#{@post.title}' updated!"
        render_flash
        format.html { redirect_to posts_path }
        format.json { render :show, status: :ok, location: @post }
      else
        flash.now[:error] = @post.errors.full_messages.join(', ')
        render_flash
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    flash.now[:notice] = "Post was successfully destroyed!"
    render_flash

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title,
                                   :body,
                                   images: [],
                                   videos: []
                                  )
    end
end
