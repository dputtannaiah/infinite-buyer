server '68.168.252.186', :app, :web, :db, :primary => true

set :app_name, 'ib'
set :application, 'infinitebuyer.com'

set :deploy_to, "#{base_path}/#{app_name}"

set :branch, 'master'

set :rails_env, 'production'
set :deploy_env, 'production'
