require "sinatra"
require "uri"

def save(title, content)
	File.open('profiles/'+title+'.txt',"w") do |file|
		file.print(content)
	end
end

def show_content(title)
	File.read("profiles/"+title)
end

get '/profiles/new' do
	erb :new
end

post '/profiles' do
	save(params[:title], params[:content])
	redirect URI.escape("/profiles/#{params[:title]}.txt")
end

get '/profiles/:title' do
	@title = params[:title]
	@content = show_content(@title)
	erb :show
end