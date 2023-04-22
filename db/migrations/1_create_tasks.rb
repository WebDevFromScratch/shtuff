Sequel.migration do
  change do
    create_table(:tasks) do
      primary_key :id
      String :name
      DateTime :created_at
      DateTime :updated_at
      DateTime :completed, default: false
    end
  end
end
