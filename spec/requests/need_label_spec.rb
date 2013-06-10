require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'need-label is outputted to class.' do
  describe 'instance variable parameter without options' do
    before do
      class UsersController < ApplicationController
        def new
          @user = User.new
          render :inline => <<-ERB
          <%= form_for @user do |f| %>
            <%= f.label :name %>
            <%= f.text_field :name %>
            <%= f.label :age %>
            <%= f.text_field :age %>
            <%= f.submit "save" %>
          <% end %>
          ERB
        end
      end
      visit '/users/new'
    end
    it 'It checks that need-label is outputted.' do
      page.has_xpath?("//label[@for='user_name'][@class='need-label']").should be_true
    end
    it 'It checks that need-label is not outputted.' do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end
  
  describe 'symbol parameter without options' do
    before do
      class UsersController < ApplicationController
        def new
          @user = User.new
          render :inline => <<-ERB
          <%= form_for :user do |f| %>
            <%= f.label :name %>
            <%= f.text_field :name %>
            <%= f.label :age %>
            <%= f.text_field :age %>
            <%= f.submit "save" %>
          <% end %>
          ERB
        end
      end
      visit '/users/new'
    end
    it 'It checks that need-label is outputted.' do
      page.has_xpath?("//label[@for='user_name'][@class='need-label']").should be_true
    end
    it 'It checks that need-label is not outputted.' do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end

  describe 'hidden option' do
    before do
      class UsersController < ApplicationController
        def new
          @user = User.new
          render :inline => <<-ERB
          <%= form_for @user do |f| %>
            <%= f.label :name, :need_label => false %>
            <%= f.text_field :name %>
            <%= f.label :age %>
            <%= f.text_field :age %>
            <%= f.submit "save" %>
          <% end %>
          ERB
        end
      end
      visit '/users/new'
    end
    it 'It checks that need-label is outputted.' do
      page.has_no_xpath?("//label[@for='user_name'][@class='need-label']").should be_true
    end
    it 'It checks that need-label is not outputted.' do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end

  describe 'specifies a class name' do
    before do
      class UsersController < ApplicationController
        def new
          @user = User.new
          render :inline => <<-ERB
          <%= form_for @user do |f| %>
            <%= f.label :name, :class => "foo" %>
            <%= f.text_field :name %>
            <%= f.label :age %>
            <%= f.text_field :age %>
            <%= f.submit "save" %>
          <% end %>
          ERB
        end
      end
      visit '/users/new'
    end
    it 'It checks that need-label is outputted.' do
      page.has_xpath?("//label[@for='user_name'][@class='foo need-label']").should be_true
    end
    it 'It checks that need-label is not outputted.' do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end

  describe 'specifies a class and hidden options.' do
    before do
      class UsersController < ApplicationController
        def new
          @user = User.new
          render :inline => <<-ERB
          <%= form_for @user do |f| %>
            <%= f.label :name, :class => "foo", :need_label => false %>
            <%= f.text_field :name %>
            <%= f.label :age %>
            <%= f.text_field :age %>
            <%= f.submit "save" %>
          <% end %>
          ERB
        end
      end
      visit '/users/new'
    end
    it 'It checks that need-label is outputted.' do
      page.has_xpath?("//label[@for='user_name'][@class='foo']").should be_true
    end
    it 'It checks that need-label is not outputted.' do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end

  describe "proc type 'if' validate presence option added." do
    before do
      class UserWithProcsController < ApplicationController
        def new
          @user_with_proc = UserWithProc.new(:age => 21)
          render :inline => <<-ERB
          <%= form_for @user_with_proc do |f| %>
            <%= f.label :name %>
            <%= f.text_field :name %>
            <%= f.label :age %>
            <%= f.text_field :age %>
            <%= f.submit "save" %>
          <% end %>
          ERB
        end
      end
      visit '/user_with_procs/new'
    end
    it 'It checks that need-label is outputted.' do
      page.has_xpath?("//label[@for='user_with_proc_name'][@class='need-label']").should be_true
    end
  end

  describe "string type 'if' validate presence option added." do
    before do
      class UserWithStringsController < ApplicationController
        def new
          @user_with_string = UserWithString.new(:age => 21)
          render :inline => <<-ERB
          <%= form_for @user_with_string do |f| %>
            <%= f.label :name %>
            <%= f.text_field :name %>
            <%= f.label :age %>
            <%= f.text_field :age %>
            <%= f.submit "save" %>
          <% end %>
          ERB
        end
      end
      visit '/user_with_strings/new'
    end
    it 'It checks that need-label is outputted.' do
      page.has_xpath?("//label[@for='user_with_string_name'][@class='need-label']").should be_true
    end
  end

  describe "symbol type 'if' validate presence option added." do
    before do
      class UserWithSymbolsController < ApplicationController
        def new
          @user_with_symbol = UserWithSymbol.new(:age => 21)
          render :inline => <<-ERB
          <%= form_for @user_with_symbol do |f| %>
            <%= f.label :name %>
            <%= f.text_field :name %>
            <%= f.label :age %>
            <%= f.text_field :age %>
            <%= f.submit "save" %>
          <% end %>
          ERB
        end
      end
      visit '/user_with_symbols/new'
    end
    it 'It checks that need-label is outputted.' do
      page.has_xpath?("//label[@for='user_with_symbol_name'][@class='need-label']").should be_true
    end
  end
end