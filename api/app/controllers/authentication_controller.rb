class AuthenticationController < ApplicationController

  before_action :authorize_request, except: [:login, :signup]

  # POST /auth/login
  def login
    @validate = {
      email: [params[:email].present? ? "" : "Email is required"],
      password: [params[:password].present? ? "" : "Password is required"],
    }

    unless params[:email].present? || params[:password].present?
      render json: { errors: @validate }, status: :unprocessable_entity and return
    end

    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      render_login_response(@user)
    else
      render json: { errors: { unauthorized: "These credentials do not match our records." } }, status: :unauthorized
    end
  end

  # POST /auth/signup
  def signup
    @user = User.new(signup_params)
    if @user.valid?(:signup)
      @user.save
      # Call the private method to log in the user after signing up
      render_login_response(@user)
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def logout
    ActiveRecord::Base.transaction do
      begin
        delete_token_sql = "delete from  rails_api.personal_access_tokens where user_id=#{params[:id]}"
        deletedUser = ActiveRecord::Base.connection.exec_delete(delete_token_sql)
        if deletedUser > 0
          render json: { message: "Token deleted successfully" }, status: :ok
        end
      rescue => e
        raise ActiveRecord::Rollback
        render json: { error: e }
      end
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def signup_params
    params.permit(:name, :profile, :email, :password, :password_confirmation, :bio)
  end

  def render_login_response(user)
    find_token_sql = "Select token from rails_api.personal_access_tokens where user_id=#{user.id}"
    result = ActiveRecord::Base.connection.execute(find_token_sql)
    token = result.to_a.flatten.first

    unless token
      token = JsonWebToken.encode(user_id: user.id)
      sql = "INSERT INTO rails_api.personal_access_tokens (user_id, token, created_at) VALUES (#{user.id}, '#{ActiveRecord::Base.sanitize_sql(token)}', '#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}')"
      ActiveRecord::Base.connection.execute(sql)
    end
    render(json: {
             user: {
               token: token,
               id: user.id,
               name: user.name,
               email: user.email,
               bio: user.bio || "",
             },
             status: :ok,
           }) && return
  end
end
