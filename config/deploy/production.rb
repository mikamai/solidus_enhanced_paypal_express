NODES = %w(cayenne@app5.caynod.es cayenne@app6.caynod.es)
role :app, NODES
role :web, NODES
#role :db,  %w(cayenne@db1.caynod.es)

set :rbenv_ruby, '2.2.3'
set :rails_env, 'production'
set :bundle_without, %w( development test staging ).join(' ')

def tag_branch_target
  tags = `git tag`.split("\n")
  tag_prompt = "\nlast tags available are #{tags.reverse[(0..5)]}"
  ask :branch_or_tag, tag_prompt
  tag = fetch(:branch_or_tag)
  tag.match(/^\d/).nil? ? tags.last : tag
end

set :branch, -> { tag_branch_target }
