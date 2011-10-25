require 'spec_helper'
require 'need_label'
require 'active_support/rescuable' # needed for Ruby 1.9.1
require 'action_controller'

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

Routes = ActionDispatch::Routing::RouteSet.new

Routes.draw do
  match ':controller(/:action(/:id(.:format)))'
end

describe "exists need_label" do
  class MyModel
    extend ActionView::Helpers::FormHelper
  end
  it "respond to need_label" do
    MyModel.respond_to?("need_label").should be_true
  end
end