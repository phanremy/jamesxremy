# frozen_string_literal: true

class TailwindBuilder < ActionView::Helpers::FormBuilder
  # include ActionView::Helpers::TagHelper
  # include ActionView::Context

  def label(attribute, text = nil, options = {})
    options[:class] = "#{options[:class]} absolute -z-1 duration-300 origin-0".strip
    options[:style] = "top: -8px; #{options[:style]}".strip
    super(attribute, text, options)
  end

  %w[email_field password_field text_field text_area date_field number_field].each do |field|
    define_method field do |attribute, options = {}|
      options[:class] = "#{options[:class]} appearance-none block w-full text-gray-700 " \
                        "border-none border-gray-400 rounded px-3 leading-tight bg-transparent".strip
      super(attribute, options)
    end
  end

  def select(object_name, method_name, template_object, options = {})
    options[:class] = "#{options[:class]} border-gray-400 rounded px-3 leading-tight bg-transparent".strip
    options[:style] = "min-width: 9em; #{options[:style]}".strip

    super(object_name, method_name, template_object, options)
  end

  # Add spinner
  def submit(attribute, options = {})
    options[:class] = "text-white font-bold py-2 px-4 rounded #{options[:class]}".strip
    if options[:disabled]
      options[:class] = "bg-gray-500 text-white cursor-not-allowed #{options[:class]}".strip
    else
      options[:class] = "bg-blue-500 hover:bg-blue-700 cursor-pointer #{options[:class]}".strip
    end

    super(attribute, options)
  end
end
