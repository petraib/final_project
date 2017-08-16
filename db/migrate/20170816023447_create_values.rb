class CreateValues < ActiveRecord::Migration[5.0]
  def change
    create_table :values do |t|
      t.integer :indicator_id
      t.date :date
      t.float :value

      t.timestamps

    end
  end
end
