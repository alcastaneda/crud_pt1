require "sinatra"
require "uri"

def save(title, content)
	@title = title
	if title.chars.last(4).join("") ==".txt"
		@title =title.chomp(".txt")
	end
	File.open('profiles/'+@title+'.txt',"w") do |file|
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

get '/profiles/:title/edit' do
	@title = params[:title]
	@content = show_content(@title)
	erb :edit
end

put '/profiles/:title' do
	save(params[:title], params[:content])
	redirect URI.escape("/profiles/#{params[:title]}")
end




















