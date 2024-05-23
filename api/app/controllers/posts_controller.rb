class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts, status: :ok
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: {errors:@post.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if params[:image].present?
      @post.remove_image!
    end
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
   if @post.destroy!
    render json:{'message':'Post is deleted successfuly.'},status: :ok
   end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.permit(:title, :category_id, :image, :description)
    end
end
