class Api::V1::TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show]

  # GET /transactions
  def index
    @transactions = Transaction.all

    render json: @transactions, status: 200
  end

  # GET /transactions/1
  def show
    render json: @transaction, status: 200
  end

  # POST /transactions
  def create
    case params[:transaction][:type]
      when 'charge' then @transaction = LoadTransaction.new(load_transaction_params)
      when 'transfer' then @transaction = TransferTransaction.new(tranfer_transaction_params)
      else
        @transaction = OpenStruct.new(errors: ({type: [{message: 'should be valid'}]}).to_json, make_transaction: false)
    end

    @transaction.make_transaction

    if @transaction.make_transaction
      head 204, location: api_v1_transaction_url(@transaction.id)
    else
      render json: @transaction.errors, status: 422
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  rescue
    head 404
  end

  def get_account
    @account = Account.find(params[:account_id])
  end

  # Only allow a trusted parameter "white list" through.
  def transaction_params
    params.require(:transaction).permit(
        :type, :value, :origin_account_id, :destination_account_id
    )
  end

  def load_transaction_params
    params.require(:transaction).permit(:type, :value, :origin_account_id)
  end

  def tranfer_transaction_params
    params.require(:transaction).permit(:type, :value, :origin_account_id, :destination_account_id)
  end
end