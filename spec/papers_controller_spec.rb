require 'spec_helper'

describe PapersController do
#  describe "GET show" do
    let (:paper) { FactoryGirl.create(:paper)}
    before {
      Paper.stub(:find_by_id).with(7).and_return(paper)
    }
    before { get "show" }
    subject { response.status }
    it { should eq 200 }
 # end
end