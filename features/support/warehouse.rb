# Module to store and retrieve test data during the test

module Warehouse

  @data ||= {}

  class << self

    attr_reader :data

    # saves key-value items within namespace, e.g.
    # save(:pet, 'id1312', {name: 'Billy', category: 'Dog', ... })

    def save(namespace, key, value)
      check_namespace(namespace)
      @data[namespace][key] = value
    end

    # retrieves key-value items within namespace or all items of a given namespace
    # load(:pet, 'id1312')

    def load(namespace, key = nil)
      check_namespace(namespace)
      key ? @data[namespace][key] : @data[namespace]
    end

    # deletes specific namespace key
    # clear_namespace_key(:pet, 'id1312')

    def clear_namespace_key(namespace, key)
      @data[namespace].delete(key)
    end

    # returns true if warehouse is empty

    def empty?
      @data.values.all?(&:empty?)
    end

    private

    def check_namespace(namespace)
      raise 'namespace can not be empty' unless namespace
      init_namespace(namespace) if namespace_absent?(namespace)
    end

    def namespace_absent?(namespace)
      !@data.key?(namespace)
    end

    def init_namespace(namespace)
      @data[namespace] = {}
    end

  end

end