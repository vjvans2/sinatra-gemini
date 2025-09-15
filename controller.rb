require 'sinatra'
require "dotenv/load"
require_relative 'sinatra_gemini'

get '/' do
  '<form action="/submit" method="post">
     <input type="text" name="message" placeholder="Type something" />
     <button type="submit">Send</button>
   </form>'
end

post '/submit' do
  task = params[:message]
  response = SinatraGemini.new.run(task)

  return "#{response}"
end

# TODO: #
# show result on main page
# cleanup formatting
# add rule pdfs/txt
# parse and cleanup the response
# cleanup the prompt so that it doesn't mention all of the irrelevant data