class CreateUser < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :phone, null: false, default: ''
      t.string :email
      t.integer :gender
      t.string :nic_number
      t.string :address
      t.string :company
      t.string :job
      t.date :date_of_birth
      t.string :zalo
      t.string :facebook
      t.integer :marital_status
      t.integer :education_grade
    end
  end
end