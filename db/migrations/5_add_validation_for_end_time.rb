Sequel.migration do
  up do
    alter_table :events do
      set_column_not_null :end_time
    end
  end

  down do
    alter_table :events do
      set_column_allow_null :end_time
    end
  end
end
