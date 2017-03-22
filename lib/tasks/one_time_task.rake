namespace :one_time_task do

  desc "Removes all test orders"
  task "destroy_test_orders" => :environment do

    old_orders = Spree::Order.where("id <= ?", 58)
    deaths = 0
    highlanders = []
    old_orders.shuffle.each do |order|
      begin
        o = order.destroy
        p "Destroyed #{o[:number]}"
        deaths += 1
      rescue
        highlanders << order
      end
    end

    p "Destroyed #{deaths} Orders, but couldn't destroy following orders:"
    highlanders.each do |h|
      p "#{h[:number]}"
    end

  end

  desc "Add 22% VAT to all non beer products"
  task "add_vat" => :environment do

    logger = Logger.new(Rails.root.join("log", "update_vat.log"))

    products = Spree::Product.joins(:taxons).where("spree_taxons.id": [3,4,5,6])

    products.each do |product|
      logger.info("Updating product #{product[:id]} - #{product.name}.")
      product.variants_including_master.each do |variant|
        logger.info("Updating variant #{variant[:id]}.")
        variant.prices.each do |price|
          amount = price[:amount]
          logger.info("Updating price #{price[:id]}: from #{amount.to_f} to #{(amount * 1.22).to_f}.")
          price.update_attribute(:amount, amount * 1.22)
        end
      end
    end

  end

  desc "Update with all old stock movements"
  task "update_stock_movements" => :environment do
    starting_time = 1490196851 ## 2017-03-22 16:34:11 +0100 because I say so
    time = Time.at starting_time
    stock_movements = Spree::StockMovement.where("created_at < ?", time)
    stock_movements.each do |sm|
      begin
        sm.stock_item.adjust_count_on_hand sm.quantity if sm.stock_item
        p "Just updated stock movement ##{sm[:id]}"
      rescue
        p "Could not adjust stock movement ##{sm[:id]}"
      end
    end
  end

end
