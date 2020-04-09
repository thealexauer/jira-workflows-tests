# frozen_string_literal: truer
require 'date'

class CustomField
  def initialize; end

  def self.get(name)
    response = Requests.get("/rest/api/2/customFields?search=#{URI.encode(name)}")
    result = response['values'].find { |x| x['name'] == name }
    return nil if result.nil?

    @fields = $issue['fields']
    if result['type'].start_with?('Text Field')
      CustomField.text_field(result)
    elsif result['type'].start_with?('Select List (single choice)')
      CustomField.single_select(result)
    elsif result['type'].start_with?('Checkboxes')
      CustomField.checkbox(result)
    elsif result['type'].start_with?('Date Time Picker')
      CustomField.datetime(result)
    elsif result['type'].start_with?('Date Picker')
      CustomField.date(result)
    end
  end

  private

  def self.text_field(result)
    @fields[result['id']]
  end

  def self.single_select(result)
    @fields[result['id']]['value']
  end

  def self.checkbox(result)
    @fields[result['id']].map {|x| x['value']}.join(', ')
  end

  def self.datetime(result)
    DateTime.parse(@fields[result['id']]).strftime(ENV['DATETIMEFORMAT'])
  end

  def self.date(result)
    DateTime.parse(@fields[result['id']]).strftime(ENV['DATEFORMAT'])
  end
end
