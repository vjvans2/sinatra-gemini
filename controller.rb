require 'sinatra'
require "dotenv/load"
require_relative 'sinatra_gemini'

# GET route (shows a simple form)
get '/' do
  '<form action="/submit" method="post">
     <input type="text" name="message" placeholder="Type something" />
     <button type="submit">Send</button>
   </form>'
end

# POST route (handles the form submission)
post '/submit' do
  task = params[:message]
  p task
  response = SinatraGemini.new.run(task)

  return "#{response}"
end