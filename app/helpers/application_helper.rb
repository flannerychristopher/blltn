module ApplicationHelper

  # page title if provided or not
  def full_title(page_title = '')
    base_title = "BLLTN"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

end
