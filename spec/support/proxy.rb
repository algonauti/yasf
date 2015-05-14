require 'digest'
require 'io/wait'
require 'webrick'
require 'webrick/httpproxy'

class VCRProxyServer < WEBrick::HTTPProxyServer
  @@pid = nil

  def self.start
    reader, writer = IO.pipe

    @@pid = fork do
      reader.close
      $stderr = writer
      server = new(
        BindAddress: Yasf.config.proxy_host,
        Port: Yasf.config.proxy_port
      )
      trap('INT') { server.shutdown }
      server.start
    end

    raise 'VCRProxyServer did not start in 10 seconds' unless reader.wait(10)
  end

  def self.stop
    Process.kill('INT', @@pid)
  end

end

RSpec.configure do |config|
  config.before :suite do
    VCRProxyServer.start
  end

  config.after :suite do
    VCRProxyServer.stop
  end

end
