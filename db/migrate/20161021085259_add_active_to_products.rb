class AddActiveToProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :active, :boolean, default: true
  end
end
