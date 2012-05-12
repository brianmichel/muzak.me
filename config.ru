APP_ROOT = File.expand_path( File.dirname(__FILE__) )
$:.push APP_ROOT

require 'app'

run Muzack::App