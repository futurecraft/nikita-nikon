module PetAPI

  # Pet endpoints wrapper
  # Includes all methods to work with pet endpoints

  class << self

    def initialize
      @host = SETTINGS.petstore.localhost_host
      @pet_api_path = SETTINGS.petstore.pet_api_path

      @headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      }
    end

    def get_pet_by_id(pet_id)
      url = @host + @pet_api_path + '/' + pet_id.to_s

      response = RestClient.get(url, @headers)
      raise "ERROR: Pet was not retrieved: #{response}" if response.code == 500

      response
    end

    def get_pets_by_status(status)
      url_helper = "/findByStatus?status=#{status}"
      url = @host + @pet_api_path + url_helper

      RestClient.get(url, @headers)
    end

    def get_pets_by_tags(tags)
      url_helper = "/findByTags?tags=#{tags.first['name']}"
      url = @host + @pet_api_path + url_helper

      RestClient.get(url, @headers)
    end

    def create_pet(pet_model)
      url = @host + @pet_api_path
      body = pet_model.to_json

      response = RestClient.post(url, body, @headers)
      raise "ERROR: Pet was not created: #{response}" if response.code == 500

      Warehouse.save(:pet, pet_model[:id], pet_model)

      LOG.info "Pet successfully created via API: #{pet_model[:name]}"

      response
    end

    def update_pet(pet, new_pet_model)
      url = @host + @pet_api_path

      # merging a few fields for data consistency [id, name]
      new_pet_model[:name] = pet['name']
      new_pet_model[:id] = pet['id']

      body = new_pet_model.to_json

      response = RestClient.put(url, body, @headers)
      raise "ERROR: Pet was not updated: #{response}" if response.code == 500

      Warehouse.save(:pet, pet['id'], new_pet_model)

      LOG.info "Pet successfully updated via API: #{pet['name']} / id: #{pet['id']}"

      response
    end

    def delete_pet(pet_id)
      url = @host + @pet_api_path + '/' + pet_id.to_s

      response = RestClient.delete(url, @headers)
      raise "ERROR: Pet was not deleted: #{response}" if response.code == 500

      Warehouse.clear_namespace_key(:pet, pet_id)

      LOG.info "Pet successfully deleted via API: #{pet_id}"

      response
    end

  end
end