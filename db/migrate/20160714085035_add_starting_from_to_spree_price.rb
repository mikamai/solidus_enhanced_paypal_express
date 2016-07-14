class AddStartingFromToSpreePrice < ActiveRecord::Migration
  def change
    add_column :spree_prices, :starting_from, :boolean, default: false
  end
end
