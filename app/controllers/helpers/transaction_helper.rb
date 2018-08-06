module TransactionHelper
  module Generator

    def self.alphanumerical_code(params)
      return false unless valid_params_alphanumerical_code(params)

      date = DateTime.now.strftime('%Y%m%d%H%M%S%L').to_s
      origin_account_id = params[:origin_account_id].to_s
      destination_account_id = params[:destination_account_id].to_s
      type = params[:type].to_s
      value = date + origin_account_id + type + destination_account_id
      Digest::MD5.hexdigest(value)
    end

   private
     def self.valid_params_alphanumerical_code(params)
      return false unless params[:origin_account_id].is_a?(Integer)
      return false unless params[:destination_account_id].is_a?(Integer) || params[:destination_account_id].blank?
      return false unless Transaction.types.keys.include?(params[:type])
    end
  end
end 