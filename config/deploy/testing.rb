server 'qwinixtech.com', :app, :web, :db, :primary => true

set :app_name, 'ib'
set :application, 'ib.qwinixtech.com'

set :deploy_to, "#{base_path}/#{app_name}"

set :branch, 'develop'

set :rails_env, 'testing'
set :deploy_env, 'testing'
