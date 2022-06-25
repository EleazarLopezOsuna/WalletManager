class Api::TypeController < ApplicationController
  before_action :set_type, only: %i[ show edit update destroy ]

  # GET /api/type or /api/type.json
  def index
    @types = Type.all
  end

  # GET /api/type/1 or /api/type/1.json
  def show

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
      render json: { message: "Created successfully" }
    else
      render json: { message: "An error has occurred" }
    end
  end

  # PATCH/PUT /api/type/1 or /api/type/1.json
  def update
    if @type.update(type_params)
      render json: { message: "Updated successfully" }
    else
      render json: { message: "An error has occurred" }
    end
  end

  # DELETE /api/type/1 or /api/type/1.json
  def destroy
    @type.destroy

    render json: { message: "Deleted successfully" }
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
