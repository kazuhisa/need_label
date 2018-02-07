# -*- coding: utf-8 -*-
require 'active_record'
require 'action_controller/railtie'
require 'action_view/helpers'
require 'need_label'

# database
# ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
config = {
  adapter: 'sqlite3',
  database: ':memory:',
}
ActiveRecord::Base.establish_connection(config)

# config
app = Class.new(Rails::Application)
app.config.secret_token = '3b7cd727ee24e8444053437c36cc66c4'
app.config.session_store :cookie_store, :key => '_myapp_session'
app.config.active_support.deprecation = :log
app.config.eager_load = false
app.initialize!

# routes
app.routes.draw do
  resources :users
  resources :user_with_procs
  resources :user_with_strings
  resources :user_with_symbols
end

# models
class User < ActiveRecord::Base
  validates :name, :presence => true
end

class UserWithProc < ActiveRecord::Base
  validates :name, :presence => true, :if => proc{self.age > 20}
end

class UserWithString < ActiveRecord::Base
  validates :name, :presence => true, :if => 'self.age > 20'
end

class UserWithSymbol < ActiveRecord::Base
  validates :name, :presence => true, :if => :age_threshold

  def age_threshold
    self.age > 20
  end
end

# controllers
class ApplicationController < ActionController::Base; end

# helpers
Object.const_set(:ApplicationHelper, Module.new)

#migrations
class CreateAllTables < ActiveRecord::Migration[4.2]
  def self.up
    create_table(:users) {|t| t.string :name; t.integer :age}
    create_table(:user_with_procs) {|t| t.string :name; t.integer :age}
    create_table(:user_with_strings) {|t| t.string :name; t.integer :age}
    create_table(:user_with_symbols) {|t| t.string :name; t.integer :age}
  end
end
