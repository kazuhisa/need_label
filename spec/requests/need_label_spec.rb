require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "output need-label class" do
  describe "GET index" do
    before do
      visit "/users"
    end
    it "experimental" do
      doc = Nokogiri::HTML(page.html)
      need_labels = doc.xpath("//*[@class='need-label']")
      need_labels[0].children[0].text.should == "Name"
    end
  end
end
