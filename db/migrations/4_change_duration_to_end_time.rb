Sequel.migration do
  change do
    alter_table(:events) do
      add_column :end_time, Time
      drop_column :duration
    end
  end
end
