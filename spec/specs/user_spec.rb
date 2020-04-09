require 'spec_helper'

describe User do
  it 'should set the user object as instance variable' do
    User.set_user 'agent'
    expect(User.get_user.username).to eql 'agent'
  end
end