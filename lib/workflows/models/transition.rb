require 'workflows/requests'
require 'json'
class Transition

  attr_accessor :name, :id

  def initialize(name, id)
    self.name = name
    self.id =id
  end

  def self.go(name)
    transition = @transitions.find {|x| x.name == name }
    return if transition.nil?
    body = {"transition": {"id": "#{transition.id}"}}.to_json
    Requests.post("/rest/api/2/issue/#{$issue['key']}/transitions", body)
  end

  def self.get_compare_list
    Transition.get.map {|x| x.name }  
  end


  def self.get
    key = $issue['key']
    response = Requests.get("/rest/api/2/issue/#{key}/transitions")
    @transitions = response['transitions'].map {|x| Transition.new(x['name'], x['id'])}
    @transitions
  end
end