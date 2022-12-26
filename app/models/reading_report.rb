class ReadingReport
  def self.search(user, query)
    case query
    when 'Daily'
      user.readings.today
    when 'Monthly'
      user.readings.monthly
    else
      user.readings.month_to_date(query)
    end
  end
end
