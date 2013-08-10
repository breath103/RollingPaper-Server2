git checkout .
git fetch origin
git pull origin master
bundle install
rake db:migrate 
bundle exec sidekiq -e production -L ./log/sidekiq.log -d
bundle exec rails server -d -e production -p 80
