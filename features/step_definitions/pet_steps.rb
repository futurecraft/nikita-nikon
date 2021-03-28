# Pet-related steps

### WHEN STEPS ###

When /^request is sent to (create|update|delete) pet$/ do |action|
  LOG.info "Sending request to #{action} the pet"

  @response = case action
              when 'create'   then PetAPI.create_pet(@model)
              when 'update'   then PetAPI.update_pet(@pet, @model)
              when 'delete'   then PetAPI.delete_pet(@pet['id'])
              else raise "ERROR: Unknown action for pet endpoint: #{action}"
              end
  @response_body = action == 'delete' ? @response : JSON.parse(@response.body)
end

When /^request is sent to retrieve pet by (id|status|tag)$/ do |type|
  @response = case type
                   when 'id'     then PetAPI.get_pet_by_id(@pet['id'])
                   when 'status' then PetAPI.get_pets_by_status(@pet['status'])
                   when 'tag'    then PetAPI.get_pets_by_tags(@pet['tags'])
                   end
  @response_body = JSON.parse(@response)
end

When /^request is sent to retrieve this unexisting pet$/ do
  @response = @response_body = PetAPI.get_pet_by_id(@model[:id])
end

When /^pet is created via API$/ do
  @pet = create_item_via_api(:pet)
end

### THEN STEPS ###

Then /^response body fields include items with the expected status$/ do
  LOG.info "Response body retrieved from API includes items with corresponding status"

  @response_body.each do |pet|
    message = "ERROR: Expected record to have #{@pet['status']}, got: #{pet['status']}"
    expect(pet['status']).to eql(@pet['status']), message
  end
end

Then /^response body fields include items with the expected tag$/ do
  LOG.info "Response body retrieved from API includes items with corresponding tag"

  sought_for_tag = @pet['tags'].first['name']

  @response_body.each do |pet|
    message = "ERROR: Expected record to have #{sought_for_tag}, didn't find it"
    expect(pet['tags'].any? { |t| t['name'] == sought_for_tag}).to eql(true), message
  end
end