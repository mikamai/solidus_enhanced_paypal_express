every 1.day, :at => "00:01am" do
  rake "paypal:capture_all_payments"
end
