require 'workflows/requests'
require 'workflows/models/custom_field'
class Issue
  def self.get id
    response = Requests.get("/rest/api/2/issue/#{id}")
    $issue = JSON.parse(response.body)
    $issue
  end

  def self.status
    $issue['fields']['status']['name']
  end

  def self.resolution
    item = $issue['fields']['resolution']
    if(item.nil?)
      'Unresolved'
    else
      item['name']
    end
  end

  def self.reporter
    item = $issue['fields']['reporter']
    return 'Anonymous' if item.nil?
    item['displayName']
  end

  def self.assignee
    item = $issue['fields']['assignee']
    return 'Unassigned' if item.nil?
    item['displayName']
  end

  def self.custom_field(name)
    CustomField.get(name)
  end


end