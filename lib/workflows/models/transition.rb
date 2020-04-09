require 'workflows/requests'

class Transition

  attr_accessor :name, :id

  def initialize(name, id)
    self.name = name
    self.id =id
  end

  def self.go(name)
    transitions = Transition.get
    transition = transitions.find {|x| x.name == name }
    return if transition.nil?

    body = {"transition": {"id": "#{transition.id}"}}

    Requests.post("/rest/api/2/issue/#{$issue['key']}/transitions", body)

    puts $issue

  end



  def self.get
    key = $issue['key']
    response = Requests.get("/rest/api/2/issue/#{key}/transitions")
    response['transitions'].map {|x| Transition.new(x['name'], x['id'])}
  end
end