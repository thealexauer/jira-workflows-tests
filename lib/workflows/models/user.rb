# frozen_string_literal: true

class User
  attr_accessor :username, :password

  # @param [String] usertype Can be customer, agent or admin
  def self.set_user(usertype)
    $user = case usertype
            when 'admin'
              User.new('admin', ENV['ADMIN_PASS'])
            when 'agent'
              User.new('agent', ENV['AGENT_PASS'])
            else
              User.new('customer', ENV['CUSTOMER_PASS'])
            end
  end

  def self.get_user
    $user
  end

  # @param [String] username The Username
  # @param [String] password The password
  def initialize(username, password)
    self.username = username
    self.password = password
  end
end
