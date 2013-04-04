require 'sinatra'
require 'json'
require 'crack'
require 'rest-client'
require 'haml'

class BoobsApp < Sinatra::Base
    get '/error' do
	haml :error
    end

    get %r{/([\D]+)} do 
	redirect '/error'
    end

    get %r{/([\d]+)} do
	id = params[:captures]
	pictures = Crack::JSON.parse(RestClient.get("api.oboobs.ru/boobs/#{id[0]}/5/-rank"))
	urls = pictures.map{|p| "http://media.oboobs.ru/" + p["preview"]}
	haml :gallery, :locals => {:urls => urls, :id => id[0]}
    end

    get '/' do
	redirect '/0'
    end
end
