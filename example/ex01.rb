# !SLIDE :capture_code_output true
# Synchronous HTTP/XML service.

require 'example_helper'
module App; include ASIR::Client; end
begin
  App.asir.transport = t =
    ASIR::Transport::Webrick.new(:uri => "http://localhost:31913/")
  t.encoder = ASIR::Coder::XML.new
  server_process do
    t.prepare_server!
    t.run_server!
  end
  pr App.asir.eval("2 + 2")
  sleep 1
rescue Object => err
  $stderr.puts "#{err.inspect}\n#{err.backtrace * "\n"}"
ensure
  t.close rescue nil; sleep 1
  server_kill
end

# !SLIDE END
# EXPECT: : client process
# EXPECT: : server process
# EXPECT: : pr: 4

