class UsersController < ApplicationController
  before_action :authorize_request, except: %i[create show profile]
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{id}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.profile= params[:profile]
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{id}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{id}
  def destroy
    if @user.destroy
      render json: { message: 'User successfully deleted' }, status: :ok
    end
  end

  def profile
    user = User.includes(:posts).find(params[:id])
    latest_post=Post.includes(:user).latest_three_data;
    categories=Category.all
    render json: {user: user.as_json(include: :posts ),
      latestPosts:latest_post.as_json(include: :user),
      categories: categories
      },status: :ok
  end

  private

  def find_user
    @user = User.find_by!(id: params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
      :name, :profile, :email, :password, :bio,
    )
  end
end
