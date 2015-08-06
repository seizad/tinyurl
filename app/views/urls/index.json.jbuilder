json.array!(@urls) do |url|
  json.extract! url, :id, :incoming, :outgoing, :http_status
  json.url url_url(url, format: :json)
end
