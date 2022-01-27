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
    # debugger
    # if params[:post][:videos].present? && params[:post][:videos].is_a?(Array)
    #   videos = params[:post][:videos].compact_blank
    #   videos.each do |video|
    #     movie = FFMPEG::Movie.new(video.tempfile.path)
    #     params.merge(metadata: { duration: movie.duration, video_codec: movie.video_codec })
    #   end
    # elsif params[:post][:videos].present?
    #   video = params[:post][:videos]
    #   movie = FFMPEG::Movie.new(video.tempfile.path)
    #   params.merge(metadata: { duration: movie.duration, video_codec: movie.video_codec })
    # end
    #
    # if params[:post][:images].present? && params[:post][:images].is_a?(Array)
    #   images = params[:post][:images].compact_blank
    #   images.each do |image|
    #     # img = FFMPEG::Movie.new(image.tempfile.path)
    #     # img = FFMPEG::Movie.new(image.tempfile.path)
    #     params.merge(metadata: { content_type: image.content_type })
    #   end
    # elsif params[:post][:images].present?
    #   image = params[:post][:images]
    #   # img = FFMPEG::Movie.new(image.tempfile.path)
    #   params.merge(metadata: { content_type: image.content_type })
    # end

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
