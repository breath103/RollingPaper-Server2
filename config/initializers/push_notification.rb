APN = Houston::Client.development
certificate_path = Rails.root.join('config', 'certifications', 'apple_push_notification_development.pem')
APN.certificate = File.read(certificate_path)