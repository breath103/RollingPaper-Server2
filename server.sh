git checkout .
git fetch origin
git pull origin master
bundle exec sidekiq -L ./log/sidekiq.log -d
bundle exec rails server -d -e production -p 80
