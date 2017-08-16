class CreateIndicators < ActiveRecord::Migration[5.0]
  def change
    create_table :indicators do |t|
      t.string :name
      t.string :description
      t.integer :expected_sign

      t.timestamps

    end
  end
end
