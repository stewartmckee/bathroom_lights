require 'pi_piper'
require 'sinatra'
require 'haml'
include PiPiper

module BathroomLights
  class Server < Sinatra::Base
    pins = []
    pins << PiPiper::Pin.new(:pin => 5, :direction => :out)
    pins << PiPiper::Pin.new(:pin => 26, :direction => :out)
    pins << PiPiper::Pin.new(:pin => 9, :direction => :out)
    pins << PiPiper::Pin.new(:pin => 27, :direction => :out)

    modePin = PiPiper::Pin.new(:pin => 6, :direction => :out)
    modePin.on

    set :bind, '0.0.0.0'

    get '/' do
      haml :index, :layout => :layout
    end

    get '/on' do
      threads = []
    	pins.each do |pin|
    	  Thread.new do
    	    sleep Random.new.rand(3.0)
    	    puts "Turning #{pin.pin} on"
    	    pin.on
    	  end
    	end
    	threads.map{|t| t.join }
      sleep 20
    end

    get '/off' do
      threads = []
    	pins.each do |pin|
    	  Thread.new do
    	    sleep Random.new.rand(3.0)
    	    puts "Turning #{pin.pin} off"
    	    pin.off
    	  end
    	end
    	threads.map{|t| t.join }
    end
  end
end
