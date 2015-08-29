class AddColumnToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :pricing, :string
  end
end
