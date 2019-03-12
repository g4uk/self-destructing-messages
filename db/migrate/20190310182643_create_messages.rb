class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages, id: false do |t|
      t.string :id, primary_key: true
      t.text :message
      t.integer :number_of_link, default: 0
      t.boolean :destructed, default: false
      t.timestamps
    end
  end
end