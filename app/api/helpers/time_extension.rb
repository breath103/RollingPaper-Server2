class Time
  def to_json
    self.to_formatted_s(:db)
  end
end