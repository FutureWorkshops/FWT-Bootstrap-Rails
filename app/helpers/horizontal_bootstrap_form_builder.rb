class HorizontalBootstrapFormBuilder < BootstrapFormBuilder  
  
  def bootstrap_input(name, input, include_br = false)
    @template.content_tag("div",
      @template.label_tag(name, nil, :class => "col-sm-4 control-label") +
      @template.content_tag("div", input, {:class => "col-sm-8"}),
        {:class => "form-group"}
    ) 
  end
  
  def bootstrap_checkbox(name, input)
    @template.content_tag("div",
      @template.content_tag("div",
        @template.content_tag("div",
        raw("<label>#{@template.label_tag(name, input)} #{name.to_s.humanize}</label>"),
          {:class => "checkbox"}
        ), 
        {:class => "col-sm-offset-4 col-sm-8"}
      ),
      {:class => "form-group"}
    )
  end
  
end