module BootstrapHelper
  
  def button(path, text, icon, method = :get, size = :sm, data = nil)
    link_to raw("<span class='glyphicon glyphicon-#{icon}'></span> #{text}"), path, :class => "btn btn-default btn-#{size}", :method => method, :data => data  
  end
  
  def red_delete_button(path, text)
    link_to raw("<span class='glyphicon glyphicon-trash'></span> #{text}"), path, :class => "btn btn-danger", :method => :delete, :data => { confirm: "Are you sure?" }  
  end
  
  def delete_button(path, text = "Delete")
    button path, text, "trash", :delete, :sm, { confirm: "Are you sure?" }
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
  
  def bootstrap_form_for(name, *args, &block)
    options = args.extract_options!
    form_output = form_for(name, *(args << options.deep_merge(:builder => BootstrapFormBuilder, :html => { :multipart => true}))) do |builder|
      output = capture(builder, &block)      
      render_form_errors(builder.object) + content_tag("div", output, :class => "row col-md-5")      
    end

    content_tag("div", form_output, :class => "row col-md-12")
  end
  
  
  def horizontal_bootstrap_form_for(name, *args, &block)
    options = args.extract_options!
    form_output = form_for(name, *(args << options.deep_merge(:builder => HorizontalBootstrapFormBuilder, :html => { :multipart => true, :class => "form-horizontal"}))) do |builder|
      output = capture(builder, &block)      
      render_form_errors(builder.object) + content_tag("div", output, :class => "row col-md-12")      
    end

    content_tag("div", form_output, :class => "row col-md-8")
  end
  
  def render_form_errors(object)
    render("layouts/form_errors", :target => object)
  end
  
end
