# Wrapper around rest-client

require 'rest-client'

module RestClient

  def self.post(url, payload = nil, headers = {})
    Request.execute(method: :post,
                    url: url,
                    payload: payload,
                    headers: headers)
  end

  def self.get(url, headers = {})
    Request.execute(method: :get, url: url, headers: headers) do |response, request, result|
      response
    end
  end

  def self.delete(url, headers = {})
    Request.execute(method: :delete,
                    url: url,
                    headers: headers)
  end

  def self.put(url, payload = nil, headers = {})
    Request.execute(method: :put,
                    url: url,
                    payload: payload,
                    headers: headers)
  end

end