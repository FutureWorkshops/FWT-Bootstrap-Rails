require 'action_view'

class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers
  include ActionView::Context
  
  def bootstrap_input(name, input, include_br = false)
    @template.content_tag(
      "div",
      @template.label_tag(name) + input,
      {:class => "form-group"}
    ) 
  end
  
  def bootstrap_checkbox(name, input)
    @template.content_tag(
      "div",
      @template.label_tag(name) + input,
      {:class => "checkbox"}
    )
  end
  
  def cw_image_tag(name, carrierwave_version = :thumbnail, options = {})
    
    html = ""
    image_url = self.object.send(name).send(carrierwave_version).url
    if image_url
      html << image_tag(image_url)
      html << "<br/>"
    end
    
    html << self.file_field(name)

    raw(html)
  end
  
  def image(name, carrierwave_version = :thumbnail)  
    uploader = self.object.send(name)
    size = uploader.upload_size
      
    html = "<div class='form-group'>"
    html << self.label(@object_name, name)
    html << "<br/>"
    html << cw_image_tag(name, carrierwave_version)
    html << "<p class='help-block'>Image must be #{size[0]}x#{size[1]}, and less than 1MB. #{uploader.extension_white_list.map(&:upcase).join(", ")} only.</p>"
    html << "</div>"
    raw(html)
  end
  
  def datetime_select(name, *args)
    html = "<div class='form-group'>"
    html << self.label(@object_name, name)
    html << "<br/>"
    html << @template.datetime_select(@object_name, name, *(args << {:start_year => Time.now.year, :end_year => Time.now.year+1, :class => "form-control"}), {})
    html << "</div>"
    raw(html)
  end
  
  def select(name, options_for_select, options = {})
    bootstrap_input(name, super(@object_name, name, options_for_select, options, {:class => "form-control"}), true)
  end
  
  def collection_select(name, collection, value_method, text_method, options = {})
    bootstrap_input(name, super(@object_name, name, collection, value_method, text_method, options, {:class => "form-control"}))
  end
  
  def radio(name, values, options = {})    
    html = ""
    values.each do |h|
      html << self.radio_button(name, h[0])
      html << " #{h[1]}"
      html << "<br/>"
    end    
    bootstrap_input(name, raw(html))
  end
  
  def bootstrap_fields_for(name, *args, &block)
    fields_for_name = "#{@object_name}[#{name}_attributes]"
    fields_for_object = @object.send(name)
        
    fields_for(fields_for_name, fields_for_object, {:builder => BootstrapFormBuilder}, &block)    
    hidden_field(fields_for_name, :id, {:value => fields_for_object.id}) if fields_for_object && !fields_for_object.kind_of?(Hash)
  end
  
  def hidden_field(name, *args, &block)
    super(@object_name, name, *(args << options.merge(:value => @object.send(name))))
  end
  
  def self.create_tagged_field(method_name)
    define_method(method_name) do |name, *args|
      if [:file_field, :select].include? method_name
        super(@object_name, name, *args)
      elsif method_name == :radio_button
        options[:checked] = (@object.send(name) == args[0])
        super(@object_name, name, *(args << options))
      elsif method_name == :check_box
        options = args.extract_options!
        options[:checked] = (@object.send(name) == true)
        bootstrap_checkbox(name, super(@object_name, name, *(args << options)))
      else
        options = args.extract_options!
        options[:class] = "form-control"
        options[:value] = @object.kind_of?(Hash) ? @object[name] : @object.send(name)
        
        if method_name == :text_area
          options[:rows] = 15
          options[:cols] = 10
        end
        
        bootstrap_input(name, super(@object_name, name, *(args << options)))
      end
    end
  end

  field_helpers.each do |name|
    create_tagged_field(name) unless [:label, :fields_for, :hidden_field].include? name
  end
end
