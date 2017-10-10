require_relative 'contact'
require 'sinatra'

## GET REQUESTS TO THE SERVER
# =====================================================================
get '/home' do
  erb :index
end

get '/contacts'do
  @contacts = Contact.all
  erb :contacts
end

get '/about' do
  erb :about
end
# REDIRECTS
# =========================================================================
get '/' do
  redirect to('home')
end

get 'contact' do
  redirect to('contacts')
end

get 'about_me' do
  redirect to('about')
end

# Close database connection
# -------------------------------------------------------------------------
# this bit of code closes sinatra connection to database, if we dont add this then we will get timout error after 5 instances
after do
  ActiveRecord::Base.connection.close
end
# Here's why: MiniRecord (which we're using to connect our Contact class to the database) has a bad habit of opening connections to the database without closing them. After this happens five times (five being the maximum number of connections that SQLite allows to be open at once), you'll get a mysterious Timeout error if you don't have this bit of code telling Sinatra to close its database connections after each request it handles.
