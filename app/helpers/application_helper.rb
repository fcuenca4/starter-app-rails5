module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = Rails.application.config.application_name
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  # Returns 'active' if the link is the current page
  # Used on navbar links to highlight the current page
  def is_active_link?(link_path)
    current_page?(link_path) ? "active" : ""
  end
end