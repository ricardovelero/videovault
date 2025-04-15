module ApplicationHelper
  def nav_link(name, path, class_name: "")
    active_class = current_page?(path) ? "text-indigo-600 font-bold" : "text-gray-700 hover:text-indigo-400"
    full_class = [ class_name, active_class ].join(" ").strip
    link_to name, path, class: full_class
  end
end
