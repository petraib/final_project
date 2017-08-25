class AddDescriptionToOurmodels < ActiveRecord::Migration[5.1]
  def change
    add_column :ourmodels, :description, :string
  end
end
