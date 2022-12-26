class LevelValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, _value)
    return if record.reading_count <= 4

    record.errors.add attribute, (options[:message] || 'can only be store 4 times per day')
  end
end
