class AddOneToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :one, :boolean, :default  => false
  end

  def self.down
    remove_column :events, :one
  end
end
