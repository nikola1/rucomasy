class RucomasyWebApp < Sinatra::Base
  get '/task/:id' do
    @task = Task.get params[:id]
    if @task == nil
      message 'Task is missing.'
    elsif @task.contest.has_started?
      erb :task, locals: { title: @task.name }
    else
      message "Contest hasn't started yet."
    end
  end

  post '/task/:id' do
    user = User.authenticate username: params[:username],
                             password: params[:password]

    if user
      filename = file_upload params[:file]
      if filename
        task = Task.get params[:id]
        solution = Solution.new source_file: filename, language: params[:language]

        if user.submissions.new(solution: solution, task: task).save
          message "Submission successful."
        else
          message "Submission unseccessful."
        end
      else
        message "Submission unseccessful."
      end
    else
      message "Wrong username or password."
    end
  end
end