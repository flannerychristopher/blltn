class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :admin, default: false

      t.timestamps
    end
    add_index :memberships, :user_id
    add_index :memberships, :group_id
    add_index :memberships, [:user_id, :group_id], unique: true
  end
end