class CreateOurmodels < ActiveRecord::Migration[5.0]
  def change
    create_table :ourmodels do |t|
      t.string :model_weight

      t.timestamps

    end
  end
end
