require 'resque' # include resque so we can configure it

# This will make the tabs show up.
require 'resque-scheduler'
require 'resque/scheduler/server'

Resque.redis = Redis.new(:host => "secure-dusk-5988.herokuapp.com", :port => 6379)
Resque.redis.namespace = "resque:music_app"