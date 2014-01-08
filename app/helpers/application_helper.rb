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
end
