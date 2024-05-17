class AuthenticationController < ApplicationController
  before_action :authorize_request, except: [:login, :signup]

  # POST /auth/login
  def login
    @validate = {
      email:[ params[:email].present? ? '' : 'Email is required' ],
      password: [params[:password].present? ? '' : 'Password is required']
    }

    unless params[:email].present? || params[:password].present?
      render json: { errors: @validate }, status: :unprocessable_entity and return
    end

    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      render_login_response(@user)
    else
    render json: { errors: { unauthorized: 'These credentials do not match our records.' }}, status: :unauthorized
    end
  end



  # POST /auth/signup
  def signup
    @user = User.new(signup_params)
    if @user.save
      # Call the private method to log in the user after signing up
      render_login_response(@user)
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def signup_params
    params.permit(:name, :profile, :email, :password,:password_confirmation, :bio)
  end

  def render_login_response(user)
    token = JsonWebToken.encode(user_id: user.id)
    time = Time.now + 24.hours.to_i
    render(json: {
      user: {
        token: token,
        exp: time.strftime("%m-%d-%Y %H:%M"),
        id: user.id,
        name: user.name,
        email: user.email,
        bio: user.bio || ''
      },
      status: :ok
    }) && return
  end
end
