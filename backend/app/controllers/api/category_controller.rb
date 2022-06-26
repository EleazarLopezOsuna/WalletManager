class Api::CategoryController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /api/category or /api/category.json
  def index
    @category = Category.all
  end

  # GET /api/category/1 or /api/category/1.json
  def show
    if @category.blank?
      render json: {
        result: {},
        description: "Id doesnt exists"
      }, status: :not_found
    else
      render json: {
        result: @category,
        description: "Id was found"
      }, status: :ok
    end
  end

  # GET /api/category/new
  def new
    @category = Category.new
  end

  # GET /api/category/1/edit
  def edit
  end

  # POST /api/category or /api/category.json
  def create
    p category_params
    @category = Category.new(category_params)

    if @category.save
      render json: {
        result: {},
        description: "Category was created successfully"
      }, status: :ok
    else
      render json: {
        result: {},
        description: "Category could not be created"
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/category/1 or /api/category/1.json
  def update
    if @category.update(category_params)
      render json: {
        result: {},
        description: "Category updated successfully"
      }, status: :ok
    else
      render json: {
        result: {},
        description: "Id doesnt exists"
      }, status: :not_found
    end
  end

  # DELETE /api/category/1 or /api/category/1.json
  def destroy
    @category.destroy

    render json: {
      result: {},
      description: "Category deleted successfully"
    }, status: :ok
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find_by id: params[:id]
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:type_id, :name)
  end
end
