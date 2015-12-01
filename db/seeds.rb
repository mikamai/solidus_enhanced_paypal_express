Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

taxonomy_categories = Spree::Taxonomy.create!(:name => "Categories")
tax_category = Spree::TaxCategory.find_or_create_by!(:name => "Default")
shipping_category = Spree::ShippingCategory.find_or_create_by!(:name => "Default")

product_default_attrs = {
  :description => Faker::Lorem.paragraph,
  :available_on => Time.zone.now,
  :tax_category => tax_category,
  :shipping_category => shipping_category,
}

products = [
  {
    :name => "Confezione 1857",
    :price => 13.50,
  },
  {
    :name => "Confezione Kronen",
    :price => 12.00,
  },
  {
    :name => "Confezione Premium",
    :price => 11.60,
  },
  {
    :name => "Birra di Natale Forst 2L",
    :price => 25.00,
  },
  {
    :name => "Lorem Ipsum Maglietta",
    :price => 19.99,
  },
  {
    :name => "Lorem Ipsum Tote Bag",
    :price => 19.99,
  },
  {
    :name => "Lorem Ipsum Bicchiere",
    :price => 19.99,
  },
]

products.each do |product_attrs|
  puts ">> Creating Product #{product_attrs[:name]}"
  product = Spree::Product.create!(product_default_attrs.merge(product_attrs))
  product.save!
end

taxons = [
  {
    :name => "Categories",
    :taxonomy => taxonomy_categories,
    :position => 0,
  },
  {
    :name => "Beers",
    :taxonomy => taxonomy_categories,
    :parent => "Categories",
    :position => 1,
    :products => [
      Spree::Product.find_by_name!("Confezione 1857"),
      Spree::Product.find_by_name!("Confezione Kronen"),
      Spree::Product.find_by_name!("Confezione Premium"),
      Spree::Product.find_by_name!("Birra di Natale Forst 2L"),
    ]
  },
  {
    :name => "Merchandising",
    :taxonomy => taxonomy_categories,
    :parent => "Categories",
    :position => 2,
    :products => [
    ]
  },
  {
    :name => "Clothing",
    :taxonomy => taxonomy_categories,
    :parent => "Merchandising",
    :position => 1,
    :products => [
      Spree::Product.find_by_name!("Lorem Ipsum Maglietta"),
    ]
  },
  {
    :name => "Accessories",
    :taxonomy => taxonomy_categories,
    :parent => "Merchandising",
    :position => 2,
    :products => [
      Spree::Product.find_by_name!("Lorem Ipsum Tote Bag"),
    ]
  },
  {
    :name => "Glasses",
    :taxonomy => taxonomy_categories,
    :parent => "Merchandising",
    :position => 3,
    :products => [
      Spree::Product.find_by_name!("Lorem Ipsum Bicchiere"),
    ]
  },
]

taxons.each do |taxon_attrs|
  if taxon_attrs[:parent]
    puts ">> Creating Taxon #{taxon_attrs[:name]}"
    taxon_attrs[:parent] = Spree::Taxon.where(name:taxon_attrs[:parent]).first
    Spree::Taxon.create!(taxon_attrs)
  end
end
