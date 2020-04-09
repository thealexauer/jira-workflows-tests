# frozen_string_literal: true

require 'httparty'
# This class wraps httparty into a jira friendly way
class Requests
  # @param [String] url The url of the reuqest
  def self.get(url)
    response = HTTParty.get("#{ENV['BASE_URL']}#{url}",
                            basic_auth: Requests.auth,
                            headers: Requests.headers)
    Requests.handle_status_response(response)
    response
  end

  def self.post(url, body)
    response = HTTParty.post("#{ENV['BASE_URL']}#{url}",
                            basic_auth: Requests.auth,
                            headers: Requests.headers,
                            body: body)
    Requests.handle_status_response(response)
    response
  end

  private

  # @param [Response] status The response object
  def self.handle_status_response(status)
    raise BadRequestError if status == 400
  end

  # @return [Object]
  def self.auth
    { username: $user.username, password: $user.password }
  end

  def self.headers
    {
      "Content-Type": 'application/json',
      "Accept": 'application/json'
    }
  end
end
