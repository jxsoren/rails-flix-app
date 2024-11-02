module ApplicationHelper

  def nav_link_to(label, path)
    if current_page?(path)
      link_to label, path, class: "active"
    else
      link_to label, path
    end
  end

end
