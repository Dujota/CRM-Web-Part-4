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

# DYNAMIC ROUTE ::::::::::::::::::::::::
get '/contacts/:id' do
  # params[:id] contains the id from the URL
  @contact = Contact.find_by({id: params[:id].to_i}) # we are using the id key and passing in the value as that of the dynamic route and looking for that in the database of the id column
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound # this raises a browser 404 error on any ids that are not found in the database
  end
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
