require 'action_view'

class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers
  include ActionView::Context
  
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
  
  def select(name, options_for_select, *args)
    html = "<div class='form-group'>"
    html << self.label(@object_name, name)
    html << "<br/>"
    html << super(@object_name, name, options_for_select, {:include_blank => true}, :class => "form-control")
    html << "</div>"
    raw(html)
  end
  
  def radio(name, values, options = {})    
    html = "<div class='form-group'>"
    html << self.label(@object_name, "Text overlay colour")
    html << "<br/>"
    values.each do |h|
      html << self.radio_button(name, h[0])
      html << " #{h[1]}"
      html << "<br/>"
    	#html << "<br/> <input type='radio' name='#{name}' value='#{h[0]}' />&nbsp; #{h[1]}"
    end
    html << "</div>"
    raw(html)
  end
  
  def bootstrap_fields_for(name, *args, &block)
    fields_for_name = "#{@object_name}[#{name}_attributes]"
    fields_for_object = @object.send(name)
        
    fields_for(fields_for_name, fields_for_object, {:builder => BootstrapFormBuilder}, &block)    
    hidden_field(fields_for_name, :id, {:value => fields_for_object.id}) if fields_for_object
  end
  
  def self.create_tagged_field(method_name)
    define_method(method_name) do |name, *args|
      if [:file_field, :select].include? method_name
        super(@object_name, name, *args)
      elsif method_name == :radio_button
        options[:checked] = (@object.send(name) == args[0])
        super(@object_name, name, *(args << options))        
      else
        options = args.extract_options!
        options[:class] = "form-control"
        options[:value] = @object.send(name)
        
        if method_name == :text_area
          options[:rows] = 15
          options[:cols] = 10
        end
        
        if method_name == :check_box
          options[:checked] = (@object.send(name) == true)
        end
      
        @template.content_tag("div",
          @template.label_tag(name) +  
          super(@object_name, name, *(args << options)),
            {:class => "form-group"}
        )           
      end
    end
  end

  field_helpers.each do |name|
    create_tagged_field(name) unless [:label, :fields_for, :hidden_field].include? name
  end
end
