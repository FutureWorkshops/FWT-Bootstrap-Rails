module BootstrapHelper
  
  def button(path, text, icon, method = :get, size = :sm, data = nil)
    link_to raw("<span class='glyphicon glyphicon-#{icon}'></span> #{text}"), path, :class => "btn btn-default btn-#{size}", :method => method, :data => data  
  end
  
  def red_delete_button(path, text)
    link_to raw("<span class='glyphicon glyphicon-trash'></span> #{text}"), path, :class => "btn btn-danger", :method => :delete, :data => { confirm: "Are you sure?" }  
  end
  
  def delete_button(path)
    button path, "Delete", "trash", :delete, :sm, { confirm: "Are you sure?" }
  end
  
  def edit_button(path)
    button path, "Edit", "pencil"
  end
  
  def add_button(path)
    button path, "Add", "plus", :get, nil    
  end
  
  def refresh_button(path)
    button path, "Refresh", "refresh", :post, nil        
  end
  
  # todo - specify form builder as default
  # and integrate this into the BootstrapFormBuilder
  def bootstrap_form_for(name, *args, &block)
    options = args.extract_options!
    form_output = form_for(name, *(args << options.merge(:builder => BootstrapFormBuilder, :html => { :multipart => true }))) do |builder|
      output = capture(builder, &block)      
      render_form_errors(builder.object) + content_tag("div", output, :class => "row col-md-5")      
    end
  
    content_tag("div", form_output, :class => "row col-md-12")
  end
  
end
