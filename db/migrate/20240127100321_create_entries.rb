class CreateEntries < ActiveRecord::Migration[7.2]
  def change
    create_table :entries do |t|
      t.string :name
      t.string :url
      t.string :repository_url
      t.json :uses
      t.string :host
      t.string :operating_system

      t.timestamps
    end
  end
end
