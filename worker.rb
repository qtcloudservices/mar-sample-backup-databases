require 'rufus-scheduler'
$stdout.sync = true

scheduler = Rufus::Scheduler.new

scheduler.every '10s' do
  puts `bundle exec backup perform -t mdb`
end

scheduler.join
