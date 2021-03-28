# User-related steps

### WHEN STEPS ###

When /^request is sent to (create|update|delete|retrieve) user( using unexisting username)?$/ do |action, unexising|
  LOG.info "Sending request to #{action} the user"

  @response = case action
              when 'create'   then UserAPI.create_user(@model)
              when 'update'   then UserAPI.update_user(@user, @model)
              when 'delete'   then UserAPI.delete_user(@user['username'])
              when 'retrieve' then UserAPI.get_user(@user['username'])
              else raise "ERROR: Unknown action for user endpoint: #{action}"
              end
  @response_body = action == 'delete' ? [] : JSON.parse(@response.body)
end

When /^request is sent to (login|logout) user$/ do |action|
  @response = case action
              when 'login'  then UserAPI.login_user(@user)
              when 'logout' then UserAPI.logout_current_user
              else raise "ERROR: Unknown action for user endpoint: #{action}"
              end
  @response_body = @response
end

When /^request is sent to retrieve this unexisting user$/ do
  @response = @response_body = UserAPI.get_user(@model[:username])
end

When /^user is created via API$/ do
  @user = create_item_via_api(:user)
end

### THEN STEPS ###

Then /^response body includes session_id$/ do
  LOG.info "Response body includes the session_id key"

  message = "ERROR: Expected response to include session_id, got <#{@response}>"
  expect(!!(@response.match(/Logged in user session: \d+/))).to eql(true), message
end