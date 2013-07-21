require 'spec_helper'

describe PapersController, type: :request do
  describe "GET show" do
    let (:paper) { FactoryGirl.create(:paper)}
    before {
      Paper.stub(:find_by_id).with("1").and_return(paper)
      paper.state = "sended"
    }
    before { get "/papers/1" }
    describe "response" do
      subject { response.status }
      it { should eq 200 }
    end
    describe "paper" do
      subject { paper }
      its(:state) { should == "opened"}
    end
  end
end