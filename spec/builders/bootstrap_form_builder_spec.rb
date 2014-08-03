require 'spec_helper.rb'
require 'bootstrap_form_builder.rb'

class TestHelper < ActionView::Base; end

describe BootstrapFormBuilder do 
  
  let(:helper)   { TestHelper.new }
  let(:resource) { User.new }
  let(:builder)  { BootstrapFormBuilder.new :user, resource, helper, {} }
  
  describe '#checkbox' do
    let(:output) { builder.check_box :administrator }

    it 'creates a checkbox input' do
     expect(output).to have_tag('input', :with => { :id => :user_administrator, :type => :checkbox })
    end

    it 'creates a label' do
     expect(output).to include '<label'
    end
   end
   
   describe '#hidden' do

     let(:output) { builder.hidden_field :administrator }

     it 'creates a hidden input' do
      expect(output).to have_tag('input', :with => {:type => :hidden, :id => :user_administrator, :value => true})
     end
   end
    
end

class User
  attr_accessor :administrator
  
  def administrator
    true
  end
end