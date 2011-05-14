require ::File.dirname(__FILE__) + '/config/boot.rb'

use Rack::Rewrite do
  r301 %r{^/(.*)/$}, '/$1'

  r301 %r{.*}, "http://cre8ivethought.com$&", :if => Proc.new { |rack_env| /^www/.match(rack_env['SERVER_NAME']) }
end

run WebApplication
