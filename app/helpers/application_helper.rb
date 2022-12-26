module ApplicationHelper
  def flash_msg_class(type)
    case type
    when 'notice'
      'bg-info'
    when 'alert'
      'bg-danger'
    else
      ''
    end
  end
end
