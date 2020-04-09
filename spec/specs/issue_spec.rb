require 'spec_helper'

describe Issue do

  it 'should return a valid Issue object' do
    VCR.use_cassette"get_valid_issue" do
      User.set_user 'admin'
      expect(Issue.get("TEST-1")['key']).to eql 'TEST-1'
    end
  end

  it 'should show a valid status' do
    VCR.use_cassette"get_valid_issue" do
      User.set_user 'admin'
      Issue.get("TEST-1")
      expect(Issue.status).to eql 'Open'
    end
  end

  it 'should show a valid unresolved resolution' do
    VCR.use_cassette"get_valid_issue_with_no_resolution" do
      User.set_user 'admin'
      Issue.get("TEST-1")
      expect(Issue.resolution).to eql 'Unresolved'
    end
  end

  it 'should show a valid unresolved resolution' do
    VCR.use_cassette"get_valid_issue_with_resolution" do
      User.set_user 'admin'
      Issue.get("TEST-1")
      expect(Issue.resolution).to eql 'Resolved'
    end
  end

  it 'should show a valid reporter' do
    VCR.use_cassette"get_valid_issue" do
      User.set_user 'admin'
      Issue.get("TEST-1")
      expect(Issue.reporter).to eql 'Angel, Jürgen'
    end
  end

  it 'should show a empty reporter' do
    VCR.use_cassette"get_valid_issue_without_reporter_and_assignee" do
      User.set_user 'admin'
      Issue.get("TEST-1")
      expect(Issue.reporter).to eql "Anonymous"
    end
  end

  it 'should show a valid assignee' do
    VCR.use_cassette"get_valid_issue" do
      User.set_user 'admin'
      Issue.get("TEST-1")
      expect(Issue.assignee).to eql 'Alexander Auer Admin'
    end
  end

  it 'should show a empty assignee' do
    VCR.use_cassette"get_valid_issue_without_reporter_and_assignee" do
      User.set_user 'admin'
      Issue.get("TEST-1")
      expect(Issue.assignee).to eql "Unassigned"
    end
  end

  it 'should return null if field is empty' do
    VCR.use_cassette "get_valid_issue" do
      User.set_user 'admin'
      Issue.get("TEST-1")
      VCR.use_cassette "text_field_search" do
        expect(Issue.custom_field("Surname")).to eql 'Text Field Content'
      end
    end

  end

  it 'should return a valid text field value' do
    VCR.use_cassette "get_valid_issue" do
      User.set_user 'admin'
      Issue.get("TEST-1")
      VCR.use_cassette "empty_field_search" do
        expect(Issue.custom_field("Duration")).to eql nil
      end
    end
  end

  it 'should return a valid single select field value' do
    VCR.use_cassette "get_valid_issue" do
      User.set_user 'admin'
      Issue.get("TEST-1")
      VCR.use_cassette "drop_down_field_search" do
        expect(Issue.custom_field("Video conferencing system")).to eql "Adobe Connect"
      end
    end
  end

  it 'should return a valid checkbox field value' do
    VCR.use_cassette "get_valid_issue" do
      User.set_user 'admin'
      Issue.get("TEST-1")
      VCR.use_cassette "checkbox_field_search" do
        expect(Issue.custom_field("Additional information media equipment for events")).to eql "Several days"
      end
    end
  end

  it 'should return a valid datetime field value' do
    VCR.use_cassette "get_valid_issue" do
      User.set_user 'admin'
      Issue.get("TEST-1")
      VCR.use_cassette "datetime" do
        expect(Issue.custom_field("Assembly time")).to eql "16.04.2020 18:01"
      end
    end
  end

  it 'should return a valid datetime field value' do
    VCR.use_cassette "get_valid_issue" do
      User.set_user 'admin'
      Issue.get("TEST-1")
      VCR.use_cassette "date" do
        expect(Issue.custom_field("ROM day of shooting")).to eql "16.04.2020"
      end
    end
  end






end