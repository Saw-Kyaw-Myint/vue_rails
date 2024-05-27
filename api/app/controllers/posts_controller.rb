class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]

  # GET /posts
  def index
    search = params[:search].present? ? params[:search] : ""
    @posts = Post.includes(:categories, :user).search_by_title(search).order(created_at: :desc).page(params[:page]).per(5)
    latest_post = Post.includes(:user).latest_three_data
    render json: { posts: @posts.as_json(include: { categories: {}, user: {} }),
                   meta: {
             current_page: @posts.current_page,
             next_page: @posts.next_page,
             prev_page: @posts.prev_page,
             total_pages: @posts.total_pages,
             total_count: @posts.total_count,
           },
                   latestPosts: latest_post.as_json(include: :user) }, status: :ok
  end

  # GET /posts/1
  def show
    categories = Category.all
    render json: { post: @post.as_json(include: { user: {}, categories: {} }),
                   categories: categories }
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    category_ids = JSON.parse(params[:category_id])
    category_ids.each do |id|
      category_post = @post.category_posts.build(category_id: id)
    end
    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if params[:image].present?
      @post.remove_image!
      @post.assign_attributes(post_params)
    else
      @post.assign_attributes(post_params.except(:image))
    end
    @post.category_posts.destroy_all
    category_ids = JSON.parse(params[:category_id])
    category_ids.each do |id|
      category_post = @post.category_posts.build(category_id: id)
    end
    if @post.save
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.category_posts.destroy_all
    if @post.destroy!
      render json: { 'message': "Post is deleted successfuly." }, status: :ok
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.includes(:user).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.permit(:title, :user_id, :image, :description)
  end
end
