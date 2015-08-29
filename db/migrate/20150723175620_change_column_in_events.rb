class ChangeColumnInEvents < ActiveRecord::Migration
  def change
  	change_column :events, :pricing, :state
  end
end
