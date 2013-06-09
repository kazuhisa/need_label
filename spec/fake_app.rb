# -*- coding: utf-8 -*-
require 'active_record'
require 'action_controller/railtie'
require 'action_view/helpers'
require 'need_label'

# database
ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('test')

# config
app = Class.new(Rails::Application)
app.config.secret_token = '3b7cd727ee24e8444053437c36cc66c4'
app.config.session_store :cookie_store, :key => '_myapp_session'
app.config.active_support.deprecation = :log
app.initialize!

# routes
app.routes.draw do
  resources :users
  resources :user_with_procs
  resources :user_with_strings
end

# models
class User < ActiveRecord::Base
  validates :name, :presence => true
end

class UserWithProc < ActiveRecord::Base
  validates :name, :presence => true, :if => proc{self.name == 'Yamazaki'}
end

class UserWithString < ActiveRecord::Base
  validates :name, :presence => true, :if => "self.name == 'Yamazaki'"
end

# controllers
class ApplicationController < ActionController::Base; end

# helpers
Object.const_set(:ApplicationHelper, Module.new)

#migrations
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:users) {|t| t.string :name; t.integer :age}
    create_table(:user_with_procs) {|t| t.string :name; t.integer :age}
    create_table(:user_with_strings) {|t| t.string :name; t.integer :age}
  end
end
