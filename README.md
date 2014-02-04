# FwtBootstrapRails

A gem to make using Bootstrap 3 easier via form builders and helpers.

Depends on the bootstrap-sass gem.

## Installation

Add these lines to your application's Gemfile:

    gem 'fwt_bootstrap_rails'
    gem 'bootstrap-sass'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fwt_bootstrap_rails

Add bootstrap to your assets/javascript/application.js

    //= require bootstrap
    
Import bootsteap to your assets/stylesheets/application.css.scss

    @import "bootstrap";
    
Your root layout file should like this https://gist.github.com/FWMatt/8801643

You should add an _navbar.html.erb file like this https://gist.github.com/FWMatt/8801661

## Usage

Easily create properly laid out Rails forms with inbuild error messages
```
<%= bootstrap_form_for @user do |f| %>
    <%= f.text_field :email %>
    <%= f.submit "Create", :class => "btn btn-default" %>    
<% end %>
```

Use button helpers to create Bootstrap buttons. We recommend creating helper methods in your application_helper.rb in the of form:

```
def delete_button(path)
    button path, "Delete", "trash", :delete, :sm, { confirm: "Are you sure?" }
end
```
