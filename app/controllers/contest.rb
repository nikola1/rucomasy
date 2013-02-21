class RucomasyWebApp < Sinatra::Base
  get '/' do
    redirect to '/contests'
  end

  get '/contests' do
    @contests = Contest.all
    erb :contests
  end

  get '/contest/:id' do
    @contest = Contest.get params[:id]

    if @contest.nil?
      message "Contest is missing."
    elsif not @contest.has_started?
      message "Contest hasn't started yet"
    else
      erb :contest, locals: { title: @contest.name }
    end
  end
end