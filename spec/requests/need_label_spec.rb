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
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_name']")
      label[0]["class"].should == "need-label"
    end
    it "It checks that need-label is not outputted." do
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_age']")
      label[0]["class"].should be_nil
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
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_name']")
      label[0]["class"].should == "need-label"
    end
    it "It checks that need-label is not outputted." do
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_age']")
      label[0]["class"].should be_nil
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
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_name']")
      label[0]["class"].should be_nil
    end
    it "It checks that need-label is not outputted." do
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_age']")
      label[0]["class"].should be_nil
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
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_name']")
      label[0]["class"].should be_nil
    end
    it "It checks that need-label is not outputted." do
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_age']")
      label[0]["class"].should be_nil
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
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_name']")
      label[0]["class"].should == "foo need-label"
    end
    it "It checks that need-label is not outputted." do
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_age']")
      label[0]["class"].should be_nil
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
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_name']")
      label[0]["class"].should == "foo need-label"
    end
    it "It checks that need-label is not outputted." do
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_age']")
      label[0]["class"].should be_nil
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
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_name']")
      label[0]["class"].should == "foo"
    end
    it "It checks that need-label is not outputted." do
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_age']")
      label[0]["class"].should be_nil
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
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_name']")
      label[0]["class"].should == "foo"
    end
    it "It checks that need-label is not outputted." do
      doc = Nokogiri::HTML(page.html)
      label = doc.xpath("//label[@for='user_age']")
      label[0]["class"].should be_nil
    end
  end
end
