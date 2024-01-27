class CreateEntries < ActiveRecord::Migration[7.2]
  def change
    create_table :entries do |t|
      t.string :name, null: false
      t.string :url, null: false
      t.string :repository_url
      t.json :uses, default: []
      t.check_constraint "JSON_TYPE(uses) = 'array'", name: 'entry_uses_is_array'
      t.string :host
      t.string :operating_system

      t.timestamps
    end
  end
end
