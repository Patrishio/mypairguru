class AddEnhancedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :enhanced, :boolean, default: false
  end
end
