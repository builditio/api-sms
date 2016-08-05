class CreateMessages < ActiveRecord::Migration[5.0]
  def change

    create_table :messages, id: false do |t|
      ## Identifier
      t.string :message_id,                 null: false, limit: 32

      ## Foreign Keys
      t.string :from_number,                null: false, limit: 20
      t.text   :to_number,                  null: false
      t.text   :body,                       null: false
      t.text   :callback,                   null: true
      t.text   :media_url,                  null: true
      t.text   :media_file,                 null: true

      t.timestamps null: false
    end

  end
end
