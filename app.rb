require 'sinatra'
require 'json'
require 'crack'
require 'rest-client'
require 'haml'

get %r{/([\d]+)} do
	id = params[:captures]
	pictures = Crack::JSON.parse(RestClient.get("api.oboobs.ru/boobs/#{id[0]}/5/-rank"))
	urls = pictures.map{|p| "http://media.oboobs.ru/" + p["preview"]}
	haml :gallery, :locals => {:urls => urls, :id => id[0]}
end

get '/' do
	redirect '/1'
end