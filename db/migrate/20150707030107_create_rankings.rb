class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.references :keyword, index: true
      t.integer :number

      t.timestamps null: false
    end
    add_foreign_key :rankings, :keywords
  end
end
