class CreateSuppliers < ActiveRecord::Migration[6.1]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :number
      t.string :email

      t.timestamps
    end
  end
end
