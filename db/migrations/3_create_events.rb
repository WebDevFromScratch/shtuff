Sequel.migration do
  up do
    create_table(:events) do
      primary_key :id
      String :name, null: false
      String :description
      DateTime :start_time, null: false
      Integer :duration, null: false
      DateTime :created_at
      DateTime :updated_at
    end
  end

  down do
    drop_table(:events)
  end
end
