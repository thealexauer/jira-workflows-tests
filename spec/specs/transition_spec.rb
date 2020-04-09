require 'spec_helper'

describe Transition do
  it 'should transition an issue given the transition exists' do
    VCR.use_cassette "get_valid_issue" do
      User.set_user 'admin'
      Issue.get("TEST-1")
    end
      VCR.use_cassette 'transition_list' do
        Transition.get
      end
      VCR.use_cassette 'transition_success' do
        Transition.go("Cancel")
      end
      VCR.use_cassette 'issue_after_transition'  do
        Issue.get("TEST-1")
        expect(Issue.status).to eql "Cancelled"
      end
  end

  it 'compare transitions' do
    VCR.use_cassette "get_valid_issue" do
      User.set_user 'admin'
      Issue.get("TEST-1")
    end
    VCR.use_cassette 'transition_list' do
      expect(Transition.get_compare_list).to eql(["Assign to me", "Cancel", "On Hold"])
    end
  end
end
