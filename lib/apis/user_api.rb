module UserAPI

  # User endpoints wrapper
  # Includes all methods to work with user endpoints

  class << self

    def initialize
      @host = SETTINGS.petstore.localhost_host
      @user_api_path = SETTINGS.petstore.user_api_path

      @headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      }
    end

    def get_user(username)
      url = @host + @user_api_path + '/' + username

      response = RestClient.get(url, @headers)
      raise "ERROR: User was not retrieved: #{response}" if response.code == 500

      LOG.info "User info successfully retrieved via API: #{username}"

      response
    end

    def create_user(user_model)
      url = @host + @user_api_path
      body = user_model.to_json

      response = RestClient.post(url, body, @headers)
      raise "ERROR: User was not created: #{response}" if response.code == 500

      Warehouse.save(:user, user_model[:username], user_model)

      LOG.info "User successfully created via API: #{user_model[:username]}"

      response
    end

    def update_user(user, new_user_model)
      url = @host + @user_api_path + '/' + user['username']

      # merging a few fields for data consistency [id, username]
      new_user_model[:username] = user['username']
      new_user_model[:id] = user['id']

      body = new_user_model.to_json

      response = RestClient.put(url, body, @headers)
      raise "ERROR: User was not updated: #{response}" if response.code == 500

      Warehouse.save(:user, user['username'], new_user_model)

      LOG.info "User successfully updated via API: #{user['username']}"

      response
    end

    def delete_user(username)
      url = @host + @user_api_path + '/' + username

      response = RestClient.delete(url, @headers)
      raise "ERROR: User was not deleted: #{response}" if response.code == 500

      Warehouse.clear_namespace_key(:user, username)

      LOG.info "User successfully deleted via API: #{username}"

      response
    end

    def login_user(user)
      url_helper = "/login?username=#{user[:username]}&password=#{user[:password]}"
      url = @host + @user_api_path + url_helper

      RestClient.get(url, @headers)
    end

    def logout_current_user
      url = @host + @user_api_path + '/logout'

      RestClient.get(url, @headers)
    end

  end
end