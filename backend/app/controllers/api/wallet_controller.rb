class Api::WalletController < ApplicationController
  before_action :set_wallet, only: %i[ show edit update destroy ]

  # GET /api/wallet/my_wallet/1 or /api/wallet/my_wallet/1.json
  def user_wallets
    @wallets = Wallet.select(:id, :name, :active, :inFlow, :outFlow, :created_at).all.where(["user_id = ? ", params[:user_id]])
    if @wallets.blank?
      render json: {
        result: {},
        description: "Id doesnt exists"
      }, status: :not_found
    else
      render json: {
        result: @wallets,
        description: "Id was found"
      }, status: :ok
    end
  end

  # GET /api/wallet/user/summary/1
  def summary
    result_obj = ActiveRecord::Base.connection.execute("SELECT wallets.name as wallet, SUM(transactions.amount) as total, types.name as type FROM wallets, transactions, categories, types WHERE wallets.user_id = #{params[:user_id]} AND transactions.wallet_id = wallets.id AND transactions.category_id = categories.id AND categories.type_id = types.id GROUP BY wallet, type")
    wallets_data = []
    result_obj.each do |row|
      json = {
        wallet: row[0],
        total: row[1],
        type: row[2]
      }
      wallets_data.push(json)
    end

    render json: {
      result: wallets_data,
      description: "Report created"
    }, status: :ok
  end

  # GET /api/wallet/user/1 or /api/wallet/user/1.json
  def totals
    incoming = Wallet.where(["user_id = ?", params[:user_id]]).sum(:inFlow)
    outgoing = Wallet.where(["user_id = ?", params[:user_id]]).sum(:outFlow)
    total = incoming - outgoing
    render json: {
      result: {
        inFlow: incoming,
        outFlow: outgoing,
        totalFlow: total
      },
      description: ""
    }, status: :ok
  end

  # GET /api/wallet/1 or /api/wallet/1.json
  def show
    if @wallet.blank?
      render json: {
        result: {},
        description: "Id doesnt exists"
      }, status: :not_found
    else
      render json: {
        result: @wallet,
        description: "Id was found"
      }, status: :ok
    end
  end

  # GET /api/wallet/new
  def new
    @wallet = Wallet.new
  end

  # GET /api/wallet/1/edit
  def edit
  end

  # POST /api/wallet or /api/wallet.json
  def create
    @wallet = Wallet.new(wallet_params)

    if @wallet.save
      render json: {
        result: {},
        description: "Wallet was created successfully"
      }, status: :ok
    else
      render json: {
        result: {},
        description: "Wallet could not be created"
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/wallet/1 or /api/wallet/1.json
  def update
    if @wallet.update(wallet_params)
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

  # DELETE /api/wallet/1 or /api/wallet/1.json
  def destroy
    @wallet.destroy

    render json: {
      result: {},
      description: "Wallet deleted successfully"
    }, status: :ok
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_wallet
    @wallet = Wallet.find_by id: params[:id]
  end

  # Only allow a list of trusted parameters through.
  def wallet_params
    params.require(:wallet).permit(:user_id, :name, :active)
  end
end
