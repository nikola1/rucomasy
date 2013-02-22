class TaskPersistanceManager
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def save
    if @task.save
      puts "Task saved successfuly."
      print
    else
      puts "Task not saved."
    end
  end

  def delete
    TaskPersistanceManager.delete @task.id
  end

  def print
    TaskPersistanceManager.print @task
  end

  def self.fetch(id)
    if (task = Task.get id)
      new task
    else
      nil
    end
  end

  def self.create(attributes)
    new Task.new(attributes)
  end

  def self.add(attributes)
    create(attributes).save
  end

  def self.select(attributes)
    Task.all(attributes).map { |task| new task }
  end

  def self.delete(id)
    if Task.get(id).destroy
      puts "Task was successfully deleted!"
    else
      puts "The task was not deleted."
    end
  end

  def self.delete_matching(all = false, attributes)
    tasks = select attributes

    if tasks.count == 0
      puts "Such a task doesn't exist."
    elsif tasks.count == 1
      tasks.first.delete
    else
      if all
        tasks.each &:delete
      else
        tasks.each &:print
        puts "Pick one? (by task id)"
        delete STDIN.readline.to_i
      end
    end
  end

  def self.edit(attributes)
    task = fetch attributes[:id]

    if task
      attributes.each { |k, v| task.attribute_set k, v }
      if task.save
        puts "Task saved successfully."
        print task
      else
        puts "task not saved."
      end
    else
      puts "Such a task doesn't exist."
    end
  end

  def self.print(task)
    puts "Name: #{task.name}".ljust(40) + "Runner:  #{task.runner}"
    puts "Task id: #{task.id}#{', Contest: ' + task.contest.name if task.contest}".ljust(40) + "Checker: #{task.checker}"
    unless task.statement.nil?
      puts "-" * CHARS_PER_LINE
      puts "Statement:"
      puts task.statement.chars.each_slice(CHARS_PER_LINE).map { |x| x.join.lstrip }.join "\n"
    end
    puts "=" * CHARS_PER_LINE
  end

  def method_missing(name, *arg, &block)
    @task.send name, *arg, &block
  end
end
