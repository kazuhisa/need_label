require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "output need-label class" do
  describe "GET index (instance variable type)" do
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
  describe "GET index (symbol type)" do
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
end
