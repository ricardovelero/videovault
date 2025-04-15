module ApplicationHelper
  def nav_link(name, path, class_name: "")
    active_class = current_page?(path) ? "text-primary font-bold" : "text-secondary-700 hover:text-indigo-400"
    full_class = [ class_name, active_class ].join(" ").strip
    link_to name, path, class: full_class
  end
end
