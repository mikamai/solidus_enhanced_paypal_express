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

end
