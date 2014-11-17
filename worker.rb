require 'rufus-scheduler'
$stdout.sync = true

puts '=== BACKUP WORKER ==='

backup_cmd = 'bundle exec backup perform -t mdb'
puts `#{backup_cmd}`

scheduler = Rufus::Scheduler.new
scheduler.every '1h' do
  puts `#{backup_cmd}`
end

scheduler.join
