class Api::TypeController < ApplicationController
  before_action :set_type, only: %i[ show edit update destroy ]

  # GET /api/type or /api/type.json
  def index
    @types = Type.all
  end

  # GET /api/type/1 or /api/type/1.json
  def show
    if @type.nil?
      render json: {
        result: {},
        description: "Id doesnt exists"
      }, status: :not_found
    else
      render json: {
        result: @type,
        description: "Id was found"
      }, status: :ok
    end
  end

  # GET /api/type/new
  def new
    @type = Type.new
  end

  # GET /api/type/1/edit
  def edit
  end

  # POST /api/type or /api/type.json
  def create
    @type = Type.new(type_params)

    if @type.save
      render json: {
        result: {},
        description: "Type was created successfully"
      }, status: :ok
    else
      render json: {
        result: {},
        description: "Id doesnt exists"
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/type/1 or /api/type/1.json
  def update
    if @type.update(type_params)
      render json: {
        result: {},
        description: "Type updated successfully"
      }, status: :ok
    else
      render json: {
        result: {},
        description: "Id doesnt exists"
      }, status: :not_found
    end
  end

  # DELETE /api/type/1 or /api/type/1.json
  def destroy
    @type.destroy

    render json: {
      result: {},
      description: "Type deleted successfully"
    }, status: :ok
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_type
    @type = Type.find_by id: params[:id]
  end

  # Only allow a list of trusted parameters through.
  def type_params
    params.require(:type).permit(:name)
  end
end
