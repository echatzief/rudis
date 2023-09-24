require 'socket'
require 'yaml'
require 'json'

class Rudis 
    def initialize
        config = YAML.load_file('env.yml')
        @host = config['HOST']
        @port = config['PORT']
        @debug = config['DEBUG']
        @max_connections = config['MAX_CONNECTIONS']
        @client_lock = Mutex.new
        @write_lock = Mutex.new
        @alive_connections = 0
        @server = nil
        @memory = {}
        Thread.report_on_exception = false 
    end

    def start
        @server = TCPServer.new(@host, @port)
        if @debug
            puts "Rudis is running at #{@host}:#{@port}"
        end
        loop do 
            client = @server.accept

            if @debug
                puts "A new client connected from #{client.peeraddr[2]}:#{client.peeraddr[1]} (#{@alive_connections}/#{@max_connections})"
            end

            @client_lock.synchronize do 
                @alive_connections += 1
            end

            Thread.new(client) do |c|
                begin
                    while (data = c.gets)
                        event = JSON.parse(data)
                        case event['action']
                            when 'set'
                                @write_lock.synchronize do
                                    @memory[event['key']] = event['value']
                                end
                                c.flush
                            when 'get'
                                if @memory.key?(event['key'])
                                    c.puts @memory[event['key']]
                                else
                                    c.puts nil
                                end
                        end 
                    end
                rescue Exception => e
                    if @debug
                        puts "An error is thrown: #{e}"
                    end
                ensure
                    @client_lock.synchronize do
                        @alive_connections -= 1
                    end
                    
                    c.close

                    if @debug
                        puts "Client disconnected from #{c.peeraddr[2]}:#{c.peeraddr[1]} (#{@alive_connections}/#{@max_connections})"
                    end
                end
            end
        end
    end
end 
