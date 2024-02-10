module ApplicationHelper
  def render_svg(icon_name, options = {})
    file = File.read(Rails.root.join("app", "assets", "images", "#{icon_name}.svg"))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"

    options.each do |attr, value|
      case attr.to_sym
      when :class
        classes = (svg["class"] || "").split(" ")
        classes << value
        svg["class"] = classes.join(" ")
      else
        svg[attr.to_s] = value
      end
    end

    doc.to_html.html_safe
  end

  def form_label_classes(*additional_classes)
    class_names(
      "block font-medium text-gray-900",
      additional_classes
    )
  end

  def form_control_classes(*additional_classes, errored: false)
    base_classes = if errored
      "border-red-300 placeholder-red-300"
    else
      "border-gray-300"
    end
    class_names(
      base_classes,
      "flex w-full rounded-md shadow-sm",
      "focus:border-blue-500 focus:ring focus:ring-blue-500 focus:ring-opacity-50",
      additional_classes
    )
  end

  def button_classes(type: nil, size: :md)
      class_names(
        "inline-flex items-center justify-center gap-2 rounded-lg font-medium cursor-pointer border hover:ring-4",
        { "py-3 px-5"     => size == :md },
        { "py-1.5 px-2.5" => size == :sm },
        { "py-0 px-2"     => size == :xs },
        { "bg-blue-500    text-white      border-gray-200    hover:ring-blue-200"   => type == :primary },
        { "bg-transparent text-blue-500   border-blue-500    hover:ring-blue-200"   => type == :primary_ghost },
        { "bg-transparent text-initial    border-transparent hover:ring-gray-200"   => type == :ghost },
        { "bg-red-500     text-white      border-red-700     hover:ring-red-200"    => type == :danger },
        { "bg-inherit     text-red-500    border-red-500     hover:ring-red-200"    => type == :danger_ghost },
        { "bg-transparent text-initial    border-gray-200    hover:ring-gray-200"   => type == :secondary_ghost },
        { "bg-transparent text-green-500  border-green-500   hover:ring-green-200"  => type == :success_ghost },
        { "bg-transparent text-blue-500   border-blue-500    hover:ring-blue-200"   => type == :info_ghost },
        { "bg-gray-100    text-initial    border-gray-300    hover:ring-gray-200"   => type == nil },
      )
  end
end
