# Module with common methods that can be called during test execution

module CommonMethods

  # generic API items creator [pet, order, user]
  def create_item_via_api(item)
    api = get_corresponding_api(item)
    model = FactoryBot.build(item)
    response = api.send("create_#{item.to_s}", model)
    if [400, 401, 402, 500].include? response.code
      raise "ERROR: Something went wrong during '#{item}' API creation: #{response}"
    end

    JSON.parse(response.body)
  end

  # after each run test entities are retrieved from Warehouse and requests are
  # send to delete the items created by test not to clutter env
  def api_cleanup
    # todo: test if this is necessary
    cleanup_items = Warehouse.data.reject {|_, v| v.empty? }
    cleanup_items.keys.each { |item| delete_api_records_for(item) }
  end

  def delete_api_records_for(item)
    api = get_corresponding_api(item)
    identifiers = Warehouse.load(item).keys
    identifiers.each { |id| api.send("delete_#{item.to_s}", id) }
  end

  def get_corresponding_api(item)
    case item
    when :user  then UserAPI
    when :order then StoreAPI
    when :pet   then PetAPI
    else raise "ERROR: Unknown item to create via API: #{item}"
    end
  end

end