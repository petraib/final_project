class AddMnameToModel < ActiveRecord::Migration[5.1]
  def change
    add_column :models, :mname, :string
  end
end
