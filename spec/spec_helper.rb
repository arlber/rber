require 'sinatra'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'lib', 'rber.rb')

Rmmb.set(
  :environment => :test,
  :run => false,
  :raise_errors => true,
  :logging => false
)

module TestHelper

  def app
    Rber.new
  end

  def body
    last_response.body
  end

  def status
    last_response.status
  end

  include Rack::Test::Methods

end

require 'bacon'

Bacon::Context.send(:include, TestHelper)
