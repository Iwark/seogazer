class AddMemoToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :memo, :string
  end
end
