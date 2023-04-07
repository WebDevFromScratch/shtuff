require 'thor'
require 'securerandom'

# For an easier usage, set up an alias in your .bashrc or .zshrc file:
# 1. cd to the folder containing this file
# 2. run `pwd` to get the full path to this (we'll call it /path/to/)
# 3. open your .bashrc or .zshrc file in your favorite text editor (e.g. nano ~/.bashrc)
# 4. add the alias, like so: `alias stuff="ruby /path/to/shtuff.rb"`
# 5. save the file and run `source ~/.bashrc` to reload your shell
# 6. now you can run `stuff` instead of `ruby /path/to/shtuff.rb`
# 7. you can also run `stuff help` to see the list of commands & add more convenience aliases from there

class TaskManager < Thor
  desc "add_task TASK_NAME", "Add a task to the to-do list"
  def add_task(task_name)
    # Generate a short identifier for the new task
    id = SecureRandom.urlsafe_base64(6)

    # Get the current time as a formatted string
    timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")

    # Append the new task to the tasks file
    File.open("tasks.txt", "a") do |file|
      file.puts "#{id},#{task_name},#{timestamp},false"
    end

    puts "Task '#{task_name}' added to the to-do list"
  end

  desc "list_tasks", "List all tasks on the to-do list"
  def list_tasks
    puts "To-Do List:"
    puts "-----------"

    # Read the contents of the tasks file into an array
    tasks = File.readlines("tasks.txt")

    # Loop through each task and display its details
    tasks.each do |task|
      id, task_name, timestamp, completed = task.chomp.split(",")
      status = completed == "true" ? "[X]" : "[ ]"
      puts "#{status} #{id} - #{task_name} (added #{timestamp})"
    end
  end

  desc "complete_task ID", "Mark a task as complete"
  def complete_task(id)
    # Read the contents of the tasks file into an array
    tasks = File.readlines("tasks.txt")

    # Loop through each task and update its completed status if the ID matches
    tasks.each_with_index do |task, index|
      task_id, task_name, timestamp, completed = task.chomp.split(",")
      if task_id == id
        tasks[index] = "#{task_id},#{task_name},#{timestamp},true\n"
        File.write("tasks.txt", tasks.join)
        puts "Task '#{task_name}' marked as complete"
        return
      end
    end

    puts "No task found with ID '#{id}'"
  end

  desc "incomplete_task ID", "Mark a task as incomplete"
  def incomplete_task(id)
    # Read the contents of the tasks file into an array
    tasks = File.readlines("tasks.txt")

    # Loop through each task and update its completed status if the ID matches
    tasks.each_with_index do |task, index|
      task_id, task_name, timestamp, completed = task.chomp.split(",")
      if task_id == id
        tasks[index] = "#{task_id},#{task_name},#{timestamp},false\n"
        File.write("tasks.txt", tasks.join)
        puts "Task '#{task_name}' marked as incomplete"
        return
      end
    end

    puts "No task found with ID '#{id}'"
  end

  desc "add_appointment DATE TIME DESCRIPTION", "Add a new appointment to the calendar"
  def add_appointment(date, time, description)
    # TODO: Implement this method
  end

  desc "list_appointments", "List all appointments on the calendar"
  def list_appointments
    # TODO: Implement this method
  end

  desc "add_note DATE TIME DESCRIPTION", "Add a new note to the calendar"
  def add_note(date, time, description)
    # TODO: Implement this method
  end

  desc "list_notes", "List all notes on the calendar"
  def list_notes
    # TODO: Implement this method
  end
end

TaskManager.start(ARGV)
