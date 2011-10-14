class AddEventIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :event_id, :integer
  end

  def self.down
    remove_column :comments, :event_id
  end
end
