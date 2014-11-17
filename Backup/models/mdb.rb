# encoding: utf-8

##
# Backup Generated: mdb
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t mdb [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://meskyanichi.github.io/backup
#
Model.new(:mdb, 'Backup MDB') do

  if ENV['MONGODB_HOST']
    database MongoDB do |db|
      db.username           = "#{ENV['MONGODB_USER']}"
      db.password           = "#{ENV['MONGODB_PASSWORD']}"
      db.host               = "#{ENV['MONGODB_HOST']}"
      db.port               = ENV['MONGODB_PORT']
      db.ipv6               = false
      db.additional_options = []
      db.lock               = false
      db.oplog              = false
    end
  end

  if ENV['MYSQL_HOST']
    database MySQL do |db|
      # To dump all databases, set `db.name = :all` (or leave blank)
      db.name               = :all
      db.username           = "#{ENV['MYSQL_USER']}"
      db.password           = "#{ENV['MYSQL_PASSWORD']}"
      db.host               = "#{ENV['MYSQL_HOST']}"
      db.port               = ENV['MYSQL_PORT']
      db.additional_options = []
    end
  end

  if ENV['REDIS_HOST']
    database Redis do |db|
      db.mode               = :sync
      db.invoke_save        = false
      db.host               = "#{ENV['REDIS_HOST']}"
      db.password           = "#{ENV['REDIS_PASSWORD']}"
      db.port               = ENV['REDIS_PORT']
      db.additional_options = []
    end
  end

  ##
  # S3 (Copy) [Storage]
  #
  if ENV['S3_BUCKET']
    store_with S3 do |s3|
      # AWS Credentials
      s3.access_key_id     = "#{ENV['S3_ACCESS_KEY_ID']}"
      s3.secret_access_key = "#{ENV['S3_SECRET_ACCESS_KEY']}"

      s3.region             = "#{ENV['S3_REGION']}"
      s3.bucket             = "#{ENV['S3_BUCKET']}"
      s3.path               = "#{ENV['MAR_APP_ID']}-backups"
    end
  end

  ##
  # Local (Copy) [Storage]
  #
  store_with Local do |local|
    local.path       = "~/backups/"
    local.keep       = 720
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  ##
  # OpenSSL [Encryptor]
  #
  if ENV['OPENSSL_PASSWORD']
    encrypt_with OpenSSL do |encryption|
      encryption.password = "#{ENV['OPENSSL_PASSWORD']}"
      encryption.base64   = true
      encryption.salt     = true
    end
  end

  ##
  # Mail [Notifier]
  #
  if ENV['EMAIL_HOST']
    notify_by Mail do |mail|
      mail.on_success           = true
      mail.on_warning           = true
      mail.on_failure           = true

      mail.from                 = "#{ENV['MAR_APP_ID']}@qtcloudapp.com"
      mail.to                   = "#{ENV['EMAIL_TO']}"
      mail.address              = "#{ENV['EMAIL_HOST']}"
      mail.port                 = ENV['EMAIL_PORT']
      mail.user_name            = "#{ENV['EMAIL_USERNAME']}"
      mail.password             = "#{ENV['EMAIL_PASSWORD']}"
      mail.authentication       = 'plain'
    end
  end

  ##
  # Flowdock [Notifier]
  #
  if ENV['FLOWDOCK_TOKEN']
    notify_by FlowDock do |flowdock|
      flowdock.on_success = false
      flowdock.on_warning = true
      flowdock.on_failure = true

      flowdock.token      = "#{ENV['FLOWDOCK_TOKEN']}"
      flowdock.from_name  = "MAR Backupper"
      flowdock.from_email = "build+fail@flowdock.com"
      flowdock.subject    = "MAR Backup (#{ENV['MAR_APP_ID']})"
      flowdock.source     = "MAR Backupper"
      flowdock.tags       = ["mar", "backup", "#{ENV['MAR_APP_ID']}", "qtcloudservices"]
      flowdock.link       = "https://#{ENV['MAR_APP_ID']}.qtcloudapp.com"
    end
  end
end
