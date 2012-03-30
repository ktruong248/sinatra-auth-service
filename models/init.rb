require_relative 'account'
require_relative 'access_token_response'
require_relative 'error_response'

require 'memcache'
require 'rubygems'
require 'data_mapper'


DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'mysql://auth-service:auth-service-password@localhost/api_account')

@@memcache_client = MemCache.new('localhost:11211')
