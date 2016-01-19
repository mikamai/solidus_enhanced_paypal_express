#role :db,  %w(cayenne@db1.caynod.es)

server 'cayman.caynod.es', user: 'cayenne', roles: %w{app web db}

set :rbenv_ruby, '2.2.3'
set :rails_env, 'production'
set :bundle_without, %w( development test staging ).join(' ')

set :deploy_to, '/hosting/sites/forst/drunken-ibex'

def tag_branch_target
  tags = `git tag`.split("\n")
  sorted_tags = tags.sort {|n,m| Gem::Version.new(n) <=> Gem::Version.new(m)}
  tag_prompt = "\nlast tags available are #{sorted_tags.last(5).reverse}"
  ask :branch_or_tag, tag_prompt
  tag = fetch(:branch_or_tag)
  tag.match(/^\d/).nil? ? sorted_tags.last : tag
end

set :branch, -> { tag_branch_target }
