class Api::TransactionController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /api/transaction/my_transactions/:user_id
  def user_transactions
    @transactions = Transaction.joins(wallet: [:user]).where(["user_id = ? ", params[:user_id]])
    if @transactions.blank?
      render json: {
        result: {},
        description: "Id doesnt exists"
      }, status: :not_found
    else
      render json: {
        result: @transactions,
        description: "Id was found"
      }, status: :ok
    end
  end

  # GET /api/wallet_transactions/:wallet_id
  def wallet_transactions
    @transactions = Transaction.where(["wallet_id = ? ", params[:wallet_id]])
    if @transactions.blank?
      render json: {
        result: {},
        description: "Id doesnt exists"
      }, status: :not_found
    else
      render json: {
        result: @transactions,
        description: "Id was found"
      }, status: :ok
    end
  end

  # GET /api/transaction/1 or /api/transaction/1.json
  def show
    if @transaction.blank?
      render json: {
        result: {},
        description: "Id doesnt exists"
      }, status: :not_found
    else
      render json: {
        result: @transaction,
        description: "Id was found"
      }, status: :ok
    end
  end

  # GET /api/transaction/new
  def new
    @transaction = Transaction.new
  end

  # GET /api/transaction/1/edit
  def edit
  end

  # POST /api/transaction or /api/transaction.json
  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      render json: {
        result: {},
        description: "Transaction was created successfully"
      }, status: :ok
    else
      render json: {
        result: {},
        description: "Transaction could not be created"
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/transaction/1 or /api/transaction/1.json
  def update
    if @transaction.update(transaction_params)
      render json: {
        result: {},
        description: "Transaction updated successfully"
      }, status: :ok
    else
      render json: {
        result: {},
        description: "Id doesnt exists"
      }, status: :not_found
    end
  end

  # DELETE /api/transaction/1 or /api/transaction/1.json
  def destroy
    @transaction.destroy

    render json: {
      result: {},
      description: "Transaction deleted successfully"
    }, status: :ok
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find_by id: params[:id]
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:wallet_id, :category_id, :description, :amount)
  end
end
