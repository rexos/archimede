module StudentsHelper

  def sanitize_search_text( arg )
    text = arg.gsub(/\S[+:-;\/\*-]/i, '')
    text = text.strip
    text = text.split( ' ' )
    text
  end

end
