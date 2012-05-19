APP_ROOT = File.expand_path( File.dirname(__FILE__) )
$LOAD_PATH.unshift APP_ROOT

require 'app'

run Muzak::App