# BetterStack Ruby Gem

A comprehensive Ruby client for the Better Stack API, providing easy access to monitors, heartbeats, status pages, incidents, and maintenance windows.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'betterstack'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install betterstack

## Configuration

Configure the gem with your Better Stack API token:

```ruby
BetterStack.configure do |config|
  config.api_token = "your_api_token_here"
  config.timeout = 30 # optional, defaults to 30 seconds
  config.retries = 3  # optional, defaults to 3 retries
end
```

## Usage

### Monitors

```ruby
client = BetterStack.client

# List all monitors
monitors = client.monitors.list

# Get a specific monitor
monitor = client.monitors.get(monitor_id)

# Create a new monitor
new_monitor = client.monitors.create({
  monitor_type: "http",
  url: "https://example.com",
  name: "My Website",
  check_frequency: 60
})

# Update a monitor
client.monitors.update(monitor_id, { name: "Updated Name" })

# Pause/Resume monitors
client.monitors.pause(monitor_id)
client.monitors.resume(monitor_id)

# Get response times and availability
response_times = client.monitors.response_times(monitor_id)
availability = client.monitors.availability(monitor_id)

# Delete a monitor
client.monitors.delete(monitor_id)
```

### Heartbeats

```ruby
# List all heartbeats
heartbeats = client.heartbeats.list

# Create a new heartbeat
heartbeat = client.heartbeats.create({
  name: "Daily Backup",
  period: 86400,
  grace: 3600
})

# Send a heartbeat ping
client.heartbeats.ping(heartbeat_id)

# Get heartbeat checks
checks = client.heartbeats.checks(heartbeat_id)
```

### Status Pages

```ruby
# List status pages
status_pages = client.status_pages.list

# Create a status page
status_page = client.status_pages.create({
  company_name: "My Company",
  subdomain: "status",
  timezone: "UTC"
})

# Add resources to status page
client.status_pages.add_resource(status_page_id, {
  resource_id: monitor_id,
  resource_type: "Monitor"
})

# Manage subscribers
client.status_pages.add_subscriber(status_page_id, {
  email: "user@example.com"
})
```

### Incidents

```ruby
# List incidents
incidents = client.incidents.list

# Create an incident
incident = client.incidents.create({
  name: "Database Connection Issues",
  summary: "Users experiencing slow response times",
  affected_resources: [monitor_id]
})

# Add incident updates
client.incidents.add_update(incident_id, {
  message: "We are investigating the issue",
  status: "investigating"
})

# Resolve incident
client.incidents.resolve(incident_id, "Issue has been resolved")
```

## Error Handling

The gem provides specific error classes for different API responses:

```ruby
begin
  monitor = client.monitors.get(invalid_id)
rescue BetterStack::NotFoundError => e
  puts "Monitor not found: #{e.message}"
rescue BetterStack::UnauthorizedError => e
  puts "Invalid API token: #{e.message}"
rescue BetterStack::RateLimitError => e
  puts "Rate limit exceeded: #{e.message}"
rescue BetterStack::ValidationError => e
  puts "Validation failed: #{e.message}"
rescue BetterStack::APIError => e
  puts "API error: #{e.message} (Status: #{e.status})"
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sundaycarwash/betterstack-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
