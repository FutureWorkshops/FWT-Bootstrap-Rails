require 'spec_helper.rb'
require 'bootstrap_form_builder.rb'

class TestHelper < ActionView::Base; end

describe BootstrapFormBuilder do 
  
  describe '#checkbox' do

    let(:helper) { TestHelper.new }
    let(:resource)  { User.new }
    let(:builder) { BootstrapFormBuilder.new :user, resource, helper, {} }
    let(:output)    {
     builder.check_box(:administrator)
    }

    it 'wraps input and label' do
     expect(output).to have_tag('input', :with => { :id => :user_administrator })
    end

    it 'creates a label' do
     expect(output).to include '<label'
    end
   end
end

class User
  attr_accessor :administrator
end