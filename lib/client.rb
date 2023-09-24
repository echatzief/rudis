require 'socket'

class RudisClient
    @host = '0.0.0.0'
    @port = 6379
    @client = nil

    def initialize(host, port)
        @host = host
        @port = port
        @client = TCPSocket.open('0.0.0.0', 6379)
    end

    def set(key, value)
        @client.puts '{"action":"set","key":"'+key+'","value":"'+value+'"}'
    end

    def get(key)
        @client.puts '{"action":"get","key":"'+key+'"}'
        return @client.gets
    end
end