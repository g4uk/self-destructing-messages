class CreateMessageDestructions < ActiveRecord::Migration[5.2]
  def change
    create_table :message_destructions do |t|
      t.references :message, type: :string
      t.string :destruction_method
      t.string :value
    end
  end
end
