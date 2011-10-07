module ApplicationHelper
  def classify( count_or_class, include_class_text = true )
  if count_or_class.class == Fixnum
    value = ( count_or_class % 2 == 0 ? 'even' : 'odd' )
  else
    value = count_or_class.to_s.downcase
  end

  if include_class_text
    'class="' << value << '"'
  else
    value
  end
  end
end
