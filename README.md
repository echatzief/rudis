# Rudis - Redis-like In-Memory Data Store

Rudis is a simple in-memory data store inspired by Redis, implemented in Ruby. It allows you to store and retrieve key-value pairs, and it provides a basic client for interacting with the server. This README will guide you on how to set up, run, and use Rudis for your data storage needs.

## Table of Contents

- [Getting Started](#getting-started)
  - [Installation](#installation)
- [Usage](#usage)
  - [Starting the Rudis Server](#starting-the-rudis-server)
  - [Using the Rudis Client](#using-the-rudis-client)
- [Running Tests](#running-tests)
- [Contributing](#contributing)
- [License](#license)

## Getting Started

### Installation

1. Clone this repository to your local machine:

   ```shell
   git clone https://github.com/echatzief/rudis.git
   ```

2. Change into the Rudis directory:

   ```shell
   cd rudis
   ```

3. Install the required gems using Bundler:

   ```shell
   bundle install
   ```

Now you're ready to use Rudis!

## Usage

### Starting the Rudis Server

To start the Rudis server, you can import the rubis server file (`rudis.rb`) into your Ruby project and call the `start` method. This will start the server on the default host and port (0.0.0.0:6379) as specified in the `env.yml` configuration file. You can modify the configuration in `env.yml` to suit your needs.

### Using the Rudis Client

To interact with the Rudis server, you can use the `RudisClient` class provided in `rudis_client.rb`. Here's how you can use it to set and get values:

```ruby
require_relative 'rudis_client'

# Create a RudisClient instance
client = RudisClient.new('0.0.0.0', 6379)

# Set a key-value pair
client.set('my_key', 'my_value')

# Get the value for a key
retrieved_value = client.get('my_key')
puts "Retrieved value: #{retrieved_value}"
```

You can customize the host and port when creating the `RudisClient` instance to match your server's configuration.

## Running Tests

To run the RSpec tests for the RudisClient class, make sure you have RSpec installed. You can run the tests using the following command:

```shell
rspec rudis_client_store_spec.rb
```

This will execute the test cases and provide feedback on the functionality of the RudisClient.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.