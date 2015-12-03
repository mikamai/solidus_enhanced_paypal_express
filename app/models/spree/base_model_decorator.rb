Spree::Base.class_eval do
  def self.find_by(*args)
    self.where(*args).take
  end
end
