require 'thor'
require 'sequel'
require 'pry'

Sequel.extension :migration

# database management: creation, migration, etc.
DB_NAME = 'shtuff.db'
DB = Sequel.connect("sqlite://#{DB_NAME}")
Sequel::Migrator.run(DB, './db/migrations')

module Persistence
  class Task < Sequel::Model(:tasks)
    def completed_today?
      completed? && completed_at.to_date == Date.today
    end

    def completed?
      completed_at != nil
    end
  end

  class Event < Sequel::Model(:events)
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

    # Retrieve all incomplete tasks and tasks completed today
    # TODO: the 2nd statement is not working, because the timestamps are Time not Date --> Fix it
    tasks = Persistence::Task.where(completed_at: nil) || Persistence::Task.where(completed_at: Date.today)

    # Loop through each task and display its details
    tasks.each do |task|
      status = task.completed_at ? "[X]" : "[ ]"
      puts "#{status} #{task.id} - #{task.name} (added #{task.created_at})"
    end
  end

  desc "complete_task ID", "Mark a task as complete"
  def complete_task(id)
    task = Persistence::Task[id]
    task.completed_at = Time.now
    task.save

    puts "Task '#{id}' marked as complete"
  end

  desc "incomplete_task ID", "Mark a task as incomplete"
  def incomplete_task(id)
    task = Persistence::Task[id]
    task.completed_at = nil
    task.save

    puts "Task '#{id}' marked as incomplete"
  end

  desc "add_event NAME DATE TIME DURATION_MINUTES DESCRIPTION", "Add a new event to the calendar"
  def add_event(name, date, time, duration_minutes, description)
    start_time = "#{date} #{time}:00"
    end_time = Time.parse(start_time) + (duration_minutes.to_i * 60)

    event = Persistence::Event.create(
      name: name,
      start_time: start_time,
      end_time: end_time,
      description: description
    )
    puts "Event '#{event.name}' created."
  end

  desc "list_events", "List all events on the calendar"
  def list_events
    puts "Events:"
    puts "-------"
    # Retrieve all events from the events table
    events = Persistence::Event.all

    # Loop through each event and display its details
    events.each do |event|
      puts "#{event.name} (#{event.start_time} - #{event.end_time}): #{event.description}"
    end
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
