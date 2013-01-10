class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :message_text
      t.integer :user_id
      t.timestamps
    end
  end
end
