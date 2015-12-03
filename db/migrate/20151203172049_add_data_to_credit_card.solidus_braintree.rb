# This migration comes from solidus_braintree (originally 20150910170527)
class AddDataToCreditCard < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.adapter_name != 'SQLite' && ActiveRecord::Base.connection.supports_json?
      add_column :spree_credit_cards, :data, :json
    else
      add_column :spree_credit_cards, :data, :text
    end
  end
end
