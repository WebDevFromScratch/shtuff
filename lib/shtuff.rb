require 'thor'
require 'sequel'
require 'pry'

DB_NAME = 'shtuff.db'
DB = Sequel.connect("sqlite://#{DB_NAME}")
unless DB.table_exists?(:tasks)
  DB.create_table(:tasks) do
    primary_key :id
    String :name
    Boolean :completed, default: false
    DateTime :created_at
    DateTime :updated_at
  end
end

module Persistence
  class Task < Sequel::Model(:tasks)
  end
end

class Shtuff < Thor
  desc "add_task TASK_NAME", "Add a task to the to-do list"
  def add_task(task_name)
    Persistence::Task.create(name: task_name, created_at: Time.now, updated_at: Time.now)

    puts "Task '#{task_name}' added to the to-do list"
  end

  desc "list_tasks", "List all tasks on the to-do list"
  def list_tasks
    puts "To-Do List:"
    puts "-----------"

    # Retrieve all tasks from the tasks table
    tasks = Persistence::Task.all

    # Loop through each task and display its details
    tasks.each do |task|
      # id, task_name, timestamp, completed = task
      status = task.completed == 1 ? "[X]" : "[ ]"
      puts "#{status} #{task.id} - #{task.name} (added #{task.created_at})"
    end
  end

  desc "complete_task ID", "Mark a task as complete"
  def complete_task(id)
    task = Persistence::Task[id]
    task.completed = true
    task.save

    puts "Task '#{id}' marked as complete"
  end

  desc "incomplete_task ID", "Mark a task as incomplete"
  def incomplete_task(id)
    task = Persistence::Task[id]
    task.completed = false
    task.save

    puts "Task '#{id}' marked as incomplete"
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

Shtuff.start(ARGV)
