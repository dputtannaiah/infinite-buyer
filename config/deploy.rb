require 'bundler/capistrano'
require 'whenever/capistrano'
require 'capistrano_colors'
require 'capistrano-deploytags'


set :stages, ["testing", "production"]
set :default_stage, "testing"
require 'capistrano/ext/multistage'

set :deploy_via, :remote_cache
set :use_sudo, false
set :keep_releases, 10
set :git_enable_submodules, 1
set :port, 1022

set :scm, 'git'
set :user, 'deploy'
set :repository, 'git@qwinixtech.com:ib.git'
set :whenever_command, 'bundle exec whenever'
set :base_path, '/var/www/apps'

#customized
set :app_name, 'ib'
set :base_path, '/var/www/apps'

before "deploy:assets:precompile", "symlink_shared"
#before 'deploy:update_code', 'thinking_sphinx:stop'

after 'deploy:update_code', 'deploy:migrate'
#after 'deploy:update_code', 'thinking_sphinx:start'
after 'deploy:finalize_update', 'sphinx:symlink_indexes'
after 'deploy', 'deploy:cleanup'

namespace :deploy do
  desc 'Tell Passenger to restart the app.'
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :sphinx do
  desc "Symlink Sphinx indexes"
  task :symlink_indexes, :roles => [:app] do
    run "mkdir -p #{shared_path}/db/sphinx"
    run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end
end

desc "Symlink shared configs and folders on each release."
task :symlink_shared do
  run "mkdir -p #{shared_path}/config"
  run "cp -f #{release_path}/config/database.yml.example #{shared_path}/config/database.yml"
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"


  run "cp -f #{release_path}/config/paypal_adaptive.yml.example #{shared_path}/config/paypal_adaptive.yml"
  run "ln -nfs #{shared_path}/config/paypal_adaptive.yml #{release_path}/config/paypal_adaptive.yml"


  run "mkdir -p #{shared_path}/private"
  run "ln -nfs #{shared_path}/private #{release_path}/private"
end

