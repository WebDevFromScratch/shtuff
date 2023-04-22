Sequel.migration do
  change do
    drop_column :tasks, :completed
    add_column :tasks, :completed_at, DateTime
  end
end
