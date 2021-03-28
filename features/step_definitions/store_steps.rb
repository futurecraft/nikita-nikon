# Store-related steps

### WHEN STEPS ###

When /^request is sent to (create|delete|retrieve) order$/ do |action|
  @response = case action
              when 'create'   then StoreAPI.create_order(@model)
              when 'delete'   then StoreAPI.delete_order(@order['id'])
              when 'retrieve' then StoreAPI.get_order_by_id(@order['id'])
              end
  @response_body = action == 'delete' ? [] : JSON.parse(@response)
end

When /^order is created via API$/ do
  @order = create_item_via_api(:order)
end

When /^request is sent to get inventory$/ do
  @response = StoreAPI.get_inventory # (@user) - see method for details
  @response_body = JSON.parse(@response)
end