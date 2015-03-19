class AddAuthorityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authority, :integer, default: 0
  end
end
