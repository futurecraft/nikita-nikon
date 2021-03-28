# After each feature api_cleanup is called to delete
# items created during test from test API

After do
  api_cleanup unless Warehouse.empty?
end