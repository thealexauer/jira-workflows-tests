require 'spec_helper'

describe Transition do
  it 'should transition an issue given the transition exists' do
    VCR.use_cassette"get_valid_issue_2" do
      User.set_user 'admin'
      Issue.get("IT-31696")
        VCR.use_cassettes [{name: 'transition_list'}, {name: 'transition_success'}]  do
          Transition.go("Cancel")
        end
        expect(Issue.status).to eql "Cancelled"
      end
  end
end
