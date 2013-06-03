require "sinatra"
require "sinatra/reloader"

require "movies"
require "stock_quote"
require "image_suckr"
require "pry"


get "/" do
  erb :index
end

get "/movies" do
  	if params[:movies] != nil &&params[:movies].to_s.length > 0


  		@movie=params[:movies]
  		@result=Movies.find_by_title(@movie)
  		erb :moviesresults
  	else
  	erb :movies
end
end
# put begin rescue blocks around the movie code
get "/movieresults" do

  @movie = params[:title]
  a = Movies.find_by_title(@movie)
  @title = a.title
  @director = a.director
  @year = a.year
  @plot = a.plot
  @poster = a.poster 
  erb :movieresults
end  

get "/stocks" do
  @stock = params[:stock_sym]
  erb :stocks
end

get "/stockresults" do
  @symbol = params[:stock_sym]
  stock = StockQuote::Stock.quote(@symbol)
  @symbol = stock.symbol
  @high = stock.high
  erb :stockresults
end

get "/images" do
  @image = params[:image_content]
  erb :images
end


get "/imageresults" do
  @image = params[:image_content]
  suckr = ImageSuckr::GoogleSuckr.new 
  @image = suckr.get_image_content
  erb :imageresults
end
  