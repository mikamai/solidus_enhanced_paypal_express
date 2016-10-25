class AddPackagingCostToVariant < ActiveRecord::Migration
  def change
    add_column :spree_products, :packaging_cost, :decimal, precision: 10, scale: 2, default: 0
  end
end
