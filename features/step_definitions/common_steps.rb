# File contains the steps that are common for all feature files

require 'rspec/expectations'
require 'rspec/matchers'

### GIVEN STEPS ###

Given /^microservice is up and running$/ do
  LOG.info "Service is up and running"

  host = SETTINGS.petstore.localhost_host
  raise "ERROR: Host is unavailable" unless RestClient.get(host).code == 200
end

### WHEN STEPS ###

When /^(.+) model is created$/ do |item|
  LOG.info "Model created: #{item}."

  @model = FactoryBot.build(item.to_s)
end

When /^(.+) model is created without (.+) field$/ do |item, field|
  LOG.info "Model created: #{item}."

  @model = FactoryBot.build(item.to_s)
  @model.delete(field.to_sym)
end

### THEN STEPS ###

Then(/^the response contains code (\d+)$/)do |code|
  LOG.info "Response code retrieved from API matches the expected."

  message = "ERROR: Expected response code: #{code}, got #{@response.code}."
  expect(@response.code).to eql(code), message
end

Then /^response body fields match model$/ do
  LOG.info "Response body retrieved from API matches the model."

  result = @model.deep_transform_keys(&:to_s).to_a - @response_body.to_a
  message = "ERROR: Expected response body: empty, got: #{result}"

  expect(result).to be_empty, message
end

Then /^response body is empty$/ do
  LOG.info "Response body retrieved and is empty as expected."

  message = "ERROR: Expected response body: empty, got: #{@response_body}"
  expect(@response_body.empty?).to eql(true), message
end

Then /^response body includes valid (error|confirmation) message:$/ do |msg_type, text|
  LOG.info "Response body includes expected #{msg_type} message"

  message = "ERROR: Expected response body: #{text}, got: #{@response_body}"
  expect(@response_body).to include(text), message
end

Then /^response body fields match API created (pet|user|order) fields$/ do |item|
  LOG.info "Response body retrieved from API matches the model."

  api_item = case item
             when 'pet'   then @pet
             when 'user'  then @user
             when 'order' then @order
             end

  response = @response_body.is_a?(Array) ? @response_body.first : @response_body

  result = response.deep_transform_keys(&:to_s).to_a - api_item.to_a
  message = "ERROR: Expected response body: empty, got: #{result}"

  expect(result).to be_empty, message
end

Then /^response body includes the following fields:$/ do |table|
  LOG.info "Response body includes expected fields"

  table.raw.flatten.each do |field|
    message = "ERROR: Expected response body to include #{field}, it is missing"
    expect(@response_body.has_key? field).to eql(true), message
  end
end