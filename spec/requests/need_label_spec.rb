require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "output need-label class" do
  describe "instance variable type without options" do
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
      visit "/users/new"
    end
    it "It checks that need-label is outputted." do
      page.has_xpath?("//label[@for='user_name'][@class='need-label']").should be_true
    end
    it "It checks that need-label is not outputted." do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end
  
  describe "symbol type without options" do
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
      visit "/users/new"
    end
    it "It checks that need-label is outputted." do
      page.has_xpath?("//label[@for='user_name'][@class='need-label']").should be_true
    end
    it "It checks that need-label is not outputted." do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end

  describe "instance variable type with hidden option" do
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
      visit "/users/new"
    end
    it "It checks that need-label is outputted." do
      page.has_no_xpath?("//label[@for='user_name'][@class='need-label']").should be_true
    end
    it "It checks that need-label is not outputted." do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end

  describe "symbol type with hidden option" do
    before do
      class UsersController < ApplicationController
        def new
          @user = User.new
          render :inline => <<-ERB
          <%= form_for :user do |f| %>
            <%= f.label :name, :need_label => false %>
            <%= f.text_field :name %>
            <%= f.label :age %>
            <%= f.text_field :age %>
            <%= f.submit "save" %>
          <% end %>
          ERB
        end
      end
      visit "/users/new"
    end
    it "It checks that need-label is outputted." do
      page.has_no_xpath?("//label[@for='user_name'][@class='need-label']").should be_true
    end
    it "It checks that need-label is not outputted." do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end

  describe "instance variable type with class" do
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
      visit "/users/new"
    end
    it "It checks that need-label is outputted." do
      page.has_xpath?("//label[@for='user_name'][@class='foo need-label']").should be_true
    end
    it "It checks that need-label is not outputted." do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end

  describe "symbol type with class" do
    before do
      class UsersController < ApplicationController
        def new
          @user = User.new
          render :inline => <<-ERB
          <%= form_for :user do |f| %>
            <%= f.label :name, :class => "foo" %>
            <%= f.text_field :name %>
            <%= f.label :age %>
            <%= f.text_field :age %>
            <%= f.submit "save" %>
          <% end %>
          ERB
        end
      end
      visit "/users/new"
    end
    it "It checks that need-label is outputted." do
      page.has_xpath?("//label[@for='user_name'][@class='foo need-label']").should be_true
    end
    it "It checks that need-label is not outputted." do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end

  describe "instance variable type with class and hidden options" do
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
      visit "/users/new"
    end
    it "It checks that need-label is outputted." do
      page.has_xpath?("//label[@for='user_name'][@class='foo']").should be_true
    end
    it "It checks that need-label is not outputted." do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end

  describe "symbol type with class and hidden options" do
    before do
      class UsersController < ApplicationController
        def new
          @user = User.new
          render :inline => <<-ERB
          <%= form_for :user do |f| %>
            <%= f.label :name, :class => "foo", :need_label => false %>
            <%= f.text_field :name %>
            <%= f.label :age %>
            <%= f.text_field :age %>
            <%= f.submit "save" %>
          <% end %>
          ERB
        end
      end
      visit "/users/new"
    end
    it "It checks that need-label is outputted." do
      page.has_xpath?("//label[@for='user_name'][@class='foo']").should be_true
    end
    it "It checks that need-label is not outputted." do
      page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
    end
  end

  describe 'validates presence with options' do
    describe 'if is a Proc' do
      before do
        class User < ActiveRecord::Base
          validates :name, :presence => true, :if => Proc.new{1 == 1}
        end
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
        visit "/users/new"
      end
      it "It checks that need-label is outputted." do
        page.has_xpath?("//label[@for='user_name'][@class='need-label']").should be_true
      end
      it "It checks that need-label is not outputted." do
        page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
      end
    end
    describe 'if is a String' do
      before do
        class User < ActiveRecord::Base
          validates :name, :presence => true, :if => '1 == 1'
        end
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
        visit "/users/new"
      end
      it "It checks that need-label is outputted." do
        page.has_xpath?("//label[@for='user_name'][@class='need-label']").should be_true
      end
      it "It checks that need-label is not outputted." do
        page.has_xpath?("//label[@for='user_age'][not(@class)]").should be_true
      end
    end
  end

end
