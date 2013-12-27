require 'fwt_bootstrap_rails/bootstrap_helper'

module FwtBootstrapRails
  class Railtie < Rails::Railtie
    initializer "fwt_bootstrap_rails.bootstrap_helper" do
      ActionView::Base.send :include, BootstrapHelper
    end
  end
end