class RucomasyWebApp < Sinatra::Base
  get '/user/register' do
    erb :user
  end

  post '/user/register' do
      user = User.new username: params[:username], password: params[:passsword],
        password_confirmation: params[:password]

      if user.save
        message "Successful registration."
      else
        message "Unsuccessful registration."
      end
  end
end