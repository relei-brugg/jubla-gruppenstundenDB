module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "GruppenstundenDB"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def nl2br(s)
    s.gsub(/\n/, '<br>')
  end

  def link_to_if_with_block (condition, options, html_options={}, &block)
    if condition
      link_to options, html_options, &block
    else
      capture &block
    end
  end

  def replace_redactor_images (text)
    text.gsub('<img src="', '<img src="file://' + Rails.root.to_s + '/public')
  end
end
