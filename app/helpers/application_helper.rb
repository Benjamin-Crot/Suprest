module ApplicationHelper

  def current?(key, path)
     "#{key}" if current_page? path
     # We use string interpolation "#{key}" here to access the CSS classes we are going to create.
  end
end
