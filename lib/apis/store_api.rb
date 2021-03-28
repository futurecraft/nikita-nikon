module StoreAPI

  # Store endpoints wrapper
  # Includes all methods to work with store endpoints

  class << self

    def initialize
      @host = SETTINGS.petstore.localhost_host
      @store_api_path = SETTINGS.petstore.store_api_path

      @headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      }
    end

    def get_order_by_id(order_id)
      url = @host + @store_api_path + '/order/' + order_id.to_s

      response = RestClient.get(url, @headers)
      raise "ERROR: Order was not retrieved: #{response}" if response.code == 500

      response
    end

    def create_order(order_model)
      url = @host + @store_api_path + '/order'
      body = order_model.to_json

      response = RestClient.post(url, body, @headers)
      raise "ERROR: Order was not created: #{response}" if response.code == 500

      Warehouse.save(:order, order_model[:id], order_model)

      LOG.info "Order successfully created via API: #{order_model[:id]}"

      response
    end

    def delete_order(order_id)
      url = @host + @store_api_path + '/order/' + order_id.to_s

      response = RestClient.delete(url, @headers)
      raise "ERROR: Order was not deleted: #{response}" if response.code == 500

      Warehouse.clear_namespace_key(:order, order_id)

      LOG.info "Order successfully deleted via API: #{order_id}"

      response
    end

    def get_inventory # (user)
      # this session_id is unnecessary to hit this endpoint,
      # but I wanted to show that it is possible to use other framework API
      # wrapper methods, e.g. for authorization - we're using user
      # credentials to retrieve a session / token and add it to
      # headers of another request.

      # > unparsed_session = UserAPI.login_user(user)
      # > session_id = unparsed_session.match(/.+(\d)/).captures.first.to_s
      # > @headers[:session_id] = session_id

      url = @host + @store_api_path + '/inventory'

      RestClient.get(url, @headers)
    end

  end
end