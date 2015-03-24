get '/' do
  @nav = false
  erb :index
end

#takes user to main page w/ icons
get '/users/:id' do
  @nav = true

  erb :home
end

#creates new journal entry in db,redirects to get route
post '/users/:user_id/journals/new' do
  @nav = false
  journal = Journal.create(user_id: params[:user_id])
  redirect "/users/#{journal.user_id}/journals/#{journal.id}"
end

#takes user to new journal entry
get '/users/:user_id/journals/:journal_id' do
  @nav = false
  @journal_id = params[:journal_id]
  erb :new
end

#updates journal entry info
put '/users/:user_id/journals/:journal_id' do
  @nav = false
  user_id = params[:user_id]
  journal = Journal.find(params[:journal_id])
  journal.body = params[:journal][:body]
  journal.title = params[:journal][:title]
  journal.save
  redirect "/users/#{user_id}"
end

put "/test_route" do
  @nav = false
  content_type :json
  {font: params[:font]}.to_json
end

put "/users/:user_id/journals/:journal_id/update_font" do
  @nav = false
  journal = Journal.find(params[:journal_id])
  p "---------------------------"
  p params
  journal.update_attribute(:font, params[:font])
  journal.save
end

get '/read/:user_id' do
  # journals = Journal.where("title=''")
  # puts "**"*25
  # puts journals
  # journals.each do |journal|
  #   puts "88"*25
  #   puts journal
  #   journal.destroy
  # end

  @nav = false
  @user = current_user
  erb :read
end

get '/settings' do
  @nav = false
  erb :settings
end

# Sign in
post '/sessions/new' do
  @nav = false
  email = params[:email]
  # need to check if user exists first; if not, redirect '/'
  if User.exists?(:email => email)
    user = User.find_by_email(params[:email])
      if user.password == params[:password]
        session[:user_id] = user.id
        redirect "/users/#{user.id}"
      else
        redirect '/'
      end
  else
    redirect '/'
  end

end

# Sign out
delete '/sessions/:id' do
  @nav = false
  session.clear
  redirect '/'
end




# Sign up
post '/signup' do
  @nav = false
  user = User.create(params[:user])
  user.password = params[:user][:password]
  if user.save
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    session[:errors] = user.errors
    redirect '/'
  end
end
#####################################################
#NON SIGN-IN STUFF:

#create new journal entry in db
# post '/users/:user_id/journals/new' do
#   user = User.find(session[:user_id])
#   Journal.create(user_id: user.id)
#   redirect "/users/#{user.id}"
# end

















