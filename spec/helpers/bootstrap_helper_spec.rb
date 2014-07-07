require 'spec_helper.rb'
require 'bootstrap_helper.rb'

describe BootstrapHelper do 
  it "builds a button" do
    rendered = helper.button("/detail", "Detail", "pencil")

    expect(rendered).to have_tag('a', :with => { :href => '/detail', :class => 'btn btn-default btn-sm', :'data-method' => "get" }) do
      with_tag "span", :with => { :class => "glyphicon glyphicon-pencil" }
    end
    
  end  
end