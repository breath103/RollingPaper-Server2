Rabl.configure do |config|
  class ActiveSupport::TimeWithZone
    def as_json(options = {})
      "#{to_formatted_s(:db)}"
#      strftime('%Y-%m-%d %H:%M:%S')
    end
  end
  
  config.include_json_root  = false
  config.include_child_root = false
end
