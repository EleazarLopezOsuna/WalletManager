class Api::TransactionController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /api/transaction/date/:wallet_id/:date
  def filter_by_date
    @transactions = Transaction.where(["wallet_id = ? and DATE(created_at) = ? ", params[:wallet_id], params[:date]])
    check_transactions_filter
  end

  # GET /api/transaction/date/:wallet_id/:month
  def filter_by_month
    @transactions = Transaction.where(["wallet_id = ? and MONTH(created_at) = ? ", params[:wallet_id], params[:month]])
    check_transactions_filter
  end

  # GET /api/transaction/date/:wallet_id/:year
  def filter_by_year
    @transactions = Transaction.where(["wallet_id = ? and YEAR(created_at) = ? ", params[:wallet_id], params[:year]])
    check_transactions_filter
  end

  # GET /api/transaction/date/:wallet_id/:category
  def filter_by_category
    @transactions = Transaction.where(["wallet_id = ? and category_id = ? ", params[:wallet_id], params[:category]])
    check_transactions_filter
  end

  def check_transactions_filter
    if @transactions.blank?
      render json: {
        result: {},
        description: "Wallet does not exists or does not have transactions"
      }, status: :not_found
    else
      data = []
      @transactions.each do |transaction|
        json = {
          id: transaction.id,
          type: transaction.category.type.name,
          category: transaction.category.name,
          description: transaction.description,
          amount: transaction.amount
        }
        data.push(json)
      end
      render json: {
        result: data,
        description: "Transactions found"
      }, status: :ok
    end
  end

  # GET /api/transaction/report/:wallet_id
  def report
    result_obj =  ActiveRecord::Base.connection.execute("SELECT categories.name, SUM(transactions.amount) AS amount, types.name AS type FROM categories, transactions, types WHERE transactions.wallet_id = #{params[:wallet_id]} and transactions.category_id = categories.id AND categories.type_id = types.id GROUP BY categories.name, types.name")
    categories_data = []
    result_obj.each do |row|
      json = {
        name: row[0],
        amount: row[1],
        type: row[2]
      }
      categories_data.push(json)
    end

    result_obj = ActiveRecord::Base.connection.execute("SELECT types.name as type, SUM(transactions.amount) as amount FROM categories, transactions, types WHERE transactions.wallet_id = #{params[:wallet_id]} and transactions.category_id = categories.id AND categories.type_id = types.id GROUP BY types.name")
    types_data = []
    result_obj.each do |row|
      json = {
        name: row[0],
        amount: row[1]
      }
      types_data.push(json)
    end

    result_obj = ActiveRecord::Base.connection.execute("SELECT DATE(transactions.created_at) as date, SUM(transactions.amount), types.name AS type FROM categories, transactions, types WHERE transactions.wallet_id = #{params[:wallet_id]} and transactions.category_id = categories.id AND categories.type_id = types.id GROUP BY DATE(transactions.created_at), types.name")
    dates_data = []
    result_obj.each do |row|
      json = {
        name: row[0],
        amount: row[1],
        type: row[2]
      }
      dates_data.push(json)
    end

    render json: {
      result: {
        categories: categories_data,
        types: types_data,
        dates: dates_data
      },
      description: "Report created"
    }, status: :ok
  end

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
    params.require(:transaction).permit(:wallet, :category, :description, :amount)
  end
end
