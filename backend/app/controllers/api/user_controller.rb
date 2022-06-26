class Api::UserController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /api/user or /api/user.json
  def index
    @user = User.all
  end

  # GET /api/

  # GET /api/user/mail@provider.com or /api/user/mail@provider.com.json
  def show
    if @user.nil?
      render json: {
        result: {},
        description: "Id doesnt exists"
      }, status: :not_found
    else
      render json: {
        result: @user,
        description: "Id was found"
      }, status: :ok
    end
  end

  # GET /api/user/new
  def new
    @user = User.new
  end

  # GET /api/user/mail@provider.com/edit
  def edit
  end

  # POST /api/user/login or /api/user/login.json
  def login
    @user = User.where(["email = ? and password = ?", user_params[:email], user_params[:password]])
    if @user.blank?
      render json: {
        result: {},
        description: "Credentials does not match"
      }, status: :not_found
    else
      render json: {
        result: @user,
        description: "Login successfully"
      }, status: :ok
    end
  end

  # POST /api/user/register or /api/user/register.json
  def register
    @user = User.new(user_params)

    if @user.save
      render json: {
        result: {},
        description: "User was created successfully"
      }, status: :ok
    else
      render json: {
        result: {},
        description: "User could not be created"
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/user/mail@provider.com or /api/user/mail@provider.com.json
  def update
    if @user.update(user_params)
      render json: {
        result: {},
        description: "User updated successfully"
      }, status: :ok
    else
      render json: {
        result: {},
        description: "Id doesnt exists"
      }, status: :not_found
    end
  end

  # DELETE /api/user/1 or /api/user/1.json
  def destroy
    @user.destroy

    render json: {
      result: {},
      description: "User deleted successfully"
    }, status: :ok
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by email: params[:email]
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
