class AuthenticationController < ApplicationController
  before_action :authorize_request, except: [:login, :signup]

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      render_login_response(@user)
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  # POST /auth/signup
  def signup
    @user = User.new(signup_params)
    if @user.save
      # Call the private method to log in the user after signing up
      render_login_response(@user)
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def signup_params
    params.permit(:name, :profile, :email, :password, :bio)
  end

  def render_login_response(user)
    token = JsonWebToken.encode(user_id: user.id)
    time = Time.now + 24.hours.to_i
    render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                   name: user.name,
                   id: user.id }, status: :ok
  end
end