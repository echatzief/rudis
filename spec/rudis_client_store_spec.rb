require 'rspec'

require_relative '../lib/client'
require_relative '../lib/rudis'

RSpec.describe RudisClient do
    before(:all) do
        @rudis_server_thread = Thread.new do
            @server = Rudis.new
            @server.start
          end
        sleep(1)
    end

    let(:client) { RudisClient.new('0.0.0.0', 6379) }

    after(:all) do
        Thread.kill(@rudis_server_thread)
    end

    describe '#set and #get' do
        it 'sets and gets values from the Rudis server' do
            key = 'foo'
            value = 'bar'

            client.set(key, value)

            retrieved_value = client.get(key)

            expect(retrieved_value.strip).to eq(value)
        end
    end
end